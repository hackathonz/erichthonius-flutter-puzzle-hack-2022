import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/logging/logging.dart';
import 'package:swap_it/views/views.dart';
import 'package:swap_it/widgets/widgets.dart';

void main() {
  putLumberdashToWork(
    withClients: [
      ColorizeLumberdash(),
    ],
  );

  Bloc.observer = LogBlocObserver();

  final _vault = vault(
    isReleaseMode: kReleaseMode,
  );

  runApp(
    MyApp(
      vault: _vault,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Vault vault;

  const MyApp({
    Key? key,
    required final this.vault,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Vault>(
      create: (context) => vault,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GameBloc>(
            create: (context) => GameBloc(
              gameRepository: vault.lookup<GameRepository>(),
            )..add(
                LoadGameStarted(),
              ),
            lazy: false,
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc()
              ..add(
                RetrieveSettingOptionsValuesStarted(),
              ),
            lazy: false,
          ),
        ],
        child: MaterialApp(
          title: 'Swap It!',
          theme: ThemeData(
            backgroundColor: Colors.transparent,
            iconTheme: iconThemeData,
            primaryIconTheme: iconThemeData,
            textTheme: appTextTheme,
            primaryTextTheme: appTextTheme,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.transparent,
              elevation: kBottomNavigationBarElevation,
              selectedIconTheme: iconThemeData,
              unselectedIconTheme: iconThemeData,
              enableFeedback: true,
              showUnselectedLabels: false,
              showSelectedLabels: false,
            ),
            cardTheme: CardTheme(
              color: primaryCardColor,
              elevation: kCardElevation,
              shadowColor: primaryCardShadowColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kCardRadius),
                side: BorderSide.none,
              ),
            ),
            appBarTheme: const AppBarTheme(
              iconTheme: appBarIconThemeData,
              actionsIconTheme: appBarIconThemeData,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: kAppBarElevation,
              titleTextStyle: appBarTitleTextStyle,
            ),
            dialogBackgroundColor: dialogBackgroundColor,
            dialogTheme: DialogTheme(
              backgroundColor: dialogBackgroundColor,
              contentTextStyle: dialogContentTextStyle,
              titleTextStyle: dialogTitleTextStyle,
              elevation: kDialogElevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDialogRadius),
                side: BorderSide.none,
              ),
            ),
            scaffoldBackgroundColor: Colors.transparent,
          ),
          home: Scaffold(
            body: DecoratedBox(
              decoration: backgroundDecoration,
              child: Navigator(
                initialRoute: '/',
                onGenerateRoute: (settings) {
                  if (settings.name == '/') {
                    return MaterialPageRoute(
                      builder: (routeContext) {
                        return BlocBuilder<GameBloc, GameState>(
                          buildWhen: (previous, current) =>
                              current is LoadGameSuccess,
                          builder: (context, state) {
                            if (state is LoadGameSuccess) {
                              return const HomeView();
                            } else {
                              return const SplashView();
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: supportedLocales,
        ),
      ),
    );
  }
}

class Vault<T> {
  final _vault = <Type, T>{};

  void store<S extends T>(final S value) => _vault[S] = value;

  T? lookup<S extends T>() => _vault[S];
}

Vault<Object> vault({
  required final bool isReleaseMode,
}) {
  final vault = Vault<Object>();

  if (isReleaseMode) {
    vault.store<GameRepository>(
      RealGameRepository(),
    );
  } else {
    vault.store<GameRepository>(
      MockGameRepository(),
    );
  }

  return vault;
}
