part of 'app_startup_bloc.dart';

abstract class AppStartupState {
  const AppStartupState();
}

class AppStartupInitial extends AppStartupState {}

class AppStartupSuccess extends AppStartupState {}
