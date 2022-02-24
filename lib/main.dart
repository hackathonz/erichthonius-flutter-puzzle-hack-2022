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
        iconTheme: const IconThemeData(
          color: iconsColor,
        ),
        textTheme: appTextTheme,
        primaryTextTheme: appTextTheme,
      ),
      home: BlocProvider<AppStartupBloc>(
        create: (context) => AppStartupBloc()..add(AppStartupStarted()),
        child: Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: backgroundGradient,
            ),
            child: BlocBuilder<AppStartupBloc, AppStartupState>(
              builder: (context, state) {
                if (state is AppStartupSuccess) {
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
