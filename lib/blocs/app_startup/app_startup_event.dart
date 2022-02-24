part of 'app_startup_bloc.dart';

abstract class AppStartupEvent {
  const AppStartupEvent();
}

class AppStartupStarted extends AppStartupEvent {}
