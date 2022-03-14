import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/logging/logging.dart';
import 'package:swap_it/views/views.dart';
import 'package:swap_it/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initFirebase();

  putLumberdashToWork(
    withClients: [
      ColorizeLumberdash(),
    ],
  );

  Bloc.observer = LogBlocObserver();

  final _vault = await vault(
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
          BlocProvider<LeaderboardBloc>(
            create: (context) => LeaderboardBloc(
              leaderboardRepository: vault.lookup<LeaderboardRepository>(),
            )..add(
                RetrieveLeaderboardsStarted(),
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
            inputDecorationTheme: inputDecorationTheme,
            scaffoldBackgroundColor: Colors.transparent,
          ),
          home: Scaffold(
            body: DecoratedBox(
              decoration: backgroundDecoration,
              child: Navigator(
                initialRoute: '/',
                onGenerateRoute: (settings) {
                  Route? route;
                  if (settings.name == '/') {
                    route = MaterialPageRoute(
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

                  return route;
                },
              ),
            ),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
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

Future<Vault<Object>> vault({
  required final bool isReleaseMode,
}) async {
  final vault = Vault<Object>();

  if (isReleaseMode) {
    final settingsRepository = RealSettingsRepository(
      preferences: await SharedPreferences.getInstance(),
    );

    vault.store<SettingsRepository>(
      settingsRepository,
    );

    final deviceId = await settingsRepository.deviceId;

    vault.store<GameRepository>(
      RealGameRepository(
        deviceId: deviceId,
        firestore: FirebaseFirestore.instance,
      ),
    );

    vault.store<ProfileRepository>(
      RealProfileRepository(
        deviceId: deviceId,
        firestore: FirebaseFirestore.instance,
      ),
    );

    vault.store<AvatarRepository>(
      RealAvatarRepository(
        deviceId: deviceId,
        storage: FirebaseStorage.instance,
      ),
    );

    vault.store<LeaderboardRepository>(
      RealLeaderboardRepository(
        deviceId: deviceId,
        firestore: FirebaseFirestore.instance,
      ),
    );

    vault.store<ImagePicker>(
      ImagePicker(),
    );
  } else {
    vault.store<GameRepository>(
      FakeGameRepository(),
    );

    vault.store<ProfileRepository>(
      FakeProfileRepository(),
    );

    vault.store<AvatarRepository>(
      FakeAvatarRepository(),
    );

    vault.store<LeaderboardRepository>(
      FakeLeaderboardRepository(),
    );

    vault.store<SettingsRepository>(
      FakeSettingsRepository(),
    );

    vault.store<ImagePicker>(
      ImagePicker(),
    );
  }

  return vault;
}
