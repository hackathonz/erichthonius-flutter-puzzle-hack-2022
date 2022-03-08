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

class SaveGameStarted extends GameEvent {}

class SaveGameLevelPlayEntryStarted extends GameEvent {
  final GameLevelPlayEntry gameLevelPlayEntry;

  SaveGameLevelPlayEntryStarted({
    required final this.gameLevelPlayEntry,
  });
}

class PlayNextGameLevelStarted extends GameEvent {
  final GameLevel previousGameLevel;

  PlayNextGameLevelStarted({
    required final this.previousGameLevel,
  });
}

class SyncUserProfileChangesStarted extends GameEvent {
  final UserProfile userProfile;

  SyncUserProfileChangesStarted({
    required final this.userProfile,
  });
}
