import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/models/models.dart';

part 'play_game_level_event.dart';
part 'play_game_level_state.dart';

class PlayGameLevelBloc extends Bloc<PlayGameLevelEvent, PlayGameLevelState> {
  final GameLevel gameLevel;

  late Timer gameLevelTimer;

  int gameLevelTimeLeftInSeconds;

  PlayGameLevelBloc({
    required final this.gameLevel,
  })  : gameLevelTimeLeftInSeconds =
            gameLevel.difficulty.gameDuration.inSeconds,
        super(PlayGameInitial());

  @override
  Stream<PlayGameLevelState> mapEventToState(PlayGameLevelEvent event) async* {
    if (event is GameLevelStarted) {
      yield* _mapGameLevelStartedToState(event);
    } else if (event is ShuffleGameLevelStarted) {
      yield* _mapShuffleGameLevelStartedToState(event);
    } else if (event is GameLevelTimerUpdated) {
      yield* _mapGameLevelTimerUpdatedToState(event);
    }
  }

  Stream<PlayGameLevelState> _mapGameLevelStartedToState(
    GameLevelStarted event,
  ) async* {
    gameLevelTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        add(
          GameLevelTimerUpdated(),
        );
      },
    );

    yield GameLevelInitial();
  }

  Stream<PlayGameLevelState> _mapShuffleGameLevelStartedToState(
    ShuffleGameLevelStarted event,
  ) async* {}

  Stream<PlayGameLevelState> _mapGameLevelTimerUpdatedToState(
    GameLevelTimerUpdated event,
  ) async* {
    gameLevelTimeLeftInSeconds--;

    if (gameLevelTimeLeftInSeconds <= 0) {
      yield GameLevelFinish();

      gameLevelTimer.cancel();
    } else {
      yield GameLevelUpdate(
        timeLeftInSeconds: gameLevelTimeLeftInSeconds,
      );
    }
  }
}
