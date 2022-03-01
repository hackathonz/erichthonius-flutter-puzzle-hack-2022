part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class LoadGameInitial extends GameState {}

class LoadGameSuccess extends GameState {
  final Game game;

  LoadGameSuccess({
    required final this.game,
  });
}

class LoadGameFailure extends GameState {}

class StartPlayGameLevelInitial extends GameState {
  final GameLevel gameLevel;

  StartPlayGameLevelInitial({
    required final this.gameLevel,
  });
}

class PlayGameLevelFailure extends GameState {}

class SaveGameSuccess extends GameState {
  final Game game;

  SaveGameSuccess({
    required final this.game,
  });
}

class SaveGameFailure extends GameState {}

class SaveGameLevelPlayEntrySuccess extends GameState {}
