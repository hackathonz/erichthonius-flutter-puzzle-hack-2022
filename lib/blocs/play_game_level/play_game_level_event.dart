part of 'play_game_level_bloc.dart';

@immutable
abstract class PlayGameLevelEvent {}

class GameLevelStarted extends PlayGameLevelEvent {}

class GameLevelTimerUpdated extends PlayGameLevelEvent {}

class ShuffleGameLevelStarted extends PlayGameLevelEvent {}
