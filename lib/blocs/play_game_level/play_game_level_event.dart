part of 'play_game_level_bloc.dart';

@immutable
abstract class PlayGameLevelEvent {}

class GameLevelStarted extends PlayGameLevelEvent {}

class GameLevelTimerUpdated extends PlayGameLevelEvent {}

class GameLevelTilesUpdated extends PlayGameLevelEvent {
  final List<PuzzleGameTile> puzzleTiles;

  GameLevelTilesUpdated({
    required final this.puzzleTiles,
  });
}

class ShuffleGameLevelStarted extends PlayGameLevelEvent {}

class GameLevelRestarted extends PlayGameLevelEvent {}

class PlayNextLevelStarted extends PlayGameLevelEvent {}
