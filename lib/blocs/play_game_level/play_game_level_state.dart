part of 'play_game_level_bloc.dart';

@immutable
abstract class PlayGameLevelState {}

class PlayGameInitial extends PlayGameLevelState {}

class GameLevelInitial extends PlayGameLevelState {}

class GameLevelUpdate extends PlayGameLevelState {
  final int timeLeftInSeconds;

  GameLevelUpdate({
    required final this.timeLeftInSeconds,
  });
}

class GameLevelFinish extends PlayGameLevelState {}

class ShuffleGameSuccess extends PlayGameLevelState {}
