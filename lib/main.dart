import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/views/views.dart';
import 'package:swap_it/widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.transparent,
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
                  return Container();
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
