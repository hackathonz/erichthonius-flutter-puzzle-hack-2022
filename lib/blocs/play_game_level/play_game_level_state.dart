part of 'play_game_level_bloc.dart';

@immutable
abstract class PlayGameLevelState {}

class PlayGameInitial extends PlayGameLevelState {}

class GameLevelInitial extends PlayGameLevelState {
  final List<PictureTile> tiles;

  final LevelDifficulty difficulty;

  GameLevelInitial({
    required final this.difficulty,
    required final this.tiles,
  });
}

class GameLevelUpdate extends PlayGameLevelState {
  final int timeLeftInSeconds;

  GameLevelUpdate({
    required final this.timeLeftInSeconds,
  });
}

class GameLevelFinish extends PlayGameLevelState {}

class ShuffleGameSuccess extends GameLevelInitial {
  ShuffleGameSuccess({
    required final LevelDifficulty difficulty,
    required final List<PictureTile> tiles,
  }) : super(difficulty: difficulty, tiles: tiles);
}
