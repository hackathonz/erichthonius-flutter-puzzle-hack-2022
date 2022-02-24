import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:swap_it/blocs/blocs.dart';
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.transparent,
        iconTheme: iconThemeData,
        primaryIconTheme: iconThemeData,
        textTheme: appTextTheme,
        primaryTextTheme: appTextTheme,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          selectedIconTheme: iconThemeData,
          unselectedIconTheme: iconThemeData,
          enableFeedback: true,
          showUnselectedLabels: false,
          showSelectedLabels: false,
        ),
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: BlocProvider<GameBloc>(
        create: (context) => GameBloc()..add(LoadGameStarted()),
        child: Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: backgroundGradient,
            ),
            child: BlocBuilder<GameBloc, GameState>(
              buildWhen: (previous, current) => current is LoadGameSuccess,
              builder: (context, state) {
                if (state is LoadGameSuccess) {
                  return const HomeView();
                } else {
                  return const SplashView();
                }
              },
            ),
          ),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
    );
  }
}
