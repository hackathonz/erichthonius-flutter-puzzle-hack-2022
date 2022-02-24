import 'dart:async';

import 'package:bloc/bloc.dart';

part 'app_startup_event.dart';
part 'app_startup_state.dart';

class AppStartupBloc extends Bloc<AppStartupEvent, AppStartupState> {
  AppStartupBloc() : super(AppStartupInitial());

  @override
  Stream<AppStartupState> mapEventToState(
    AppStartupEvent event,
  ) async* {
    yield* _mapAppStartupStartedToState(event as AppStartupStarted);
  }

  Stream<AppStartupState> _mapAppStartupStartedToState(
    AppStartupStarted event,
  ) async* {
    await Future.wait(
      [
        Future.delayed(
          Duration(seconds: 3),
        ),
      ],
    );

    yield AppStartupSuccess();
  }
}
