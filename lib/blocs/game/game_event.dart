part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class LoadGameStarted extends GameEvent {}

class PlayGameLevelStarted extends GameEvent {
  final GameLevel gameLevel;

  PlayGameLevelStarted({
    required final this.gameLevel,
  });
}
