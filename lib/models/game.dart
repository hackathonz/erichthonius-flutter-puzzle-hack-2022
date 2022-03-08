import 'package:swap_it/models/models.dart';

class Game {
  final GameUserProfile gameUserProfile;

  final List<GameLevel> gameLevels;

  const Game({
    required final this.gameUserProfile,
    required final this.gameLevels,
  });

  bool canPlayLevel(
    final GameLevel level,
  ) {
    final levels = gameLevels
        .where(
          (x) => x.difficulty.difficulty == level.difficulty.difficulty,
        )
        .toList();

    final levelIndex = levels.indexOf(level);

    if (levelIndex == 0) {
      return true;
    } else {
      final previousGame = levels[levelIndex - 1];

      return gameUserProfile.levelsPlayed
          .where(
            (x) => x.gameLevel == previousGame && x.hasCompletedLevel,
          )
          .isNotEmpty;
    }
  }

  void registerPlayEntry(final GameLevelPlayEntry playEntry) {
    gameUserProfile.registerPlayEntry(playEntry);
  }

  Game copyWith({
    final GameUserProfile? gameUserProfile,
  }) {
    return Game(
      gameLevels: gameLevels,
      gameUserProfile: gameUserProfile ?? this.gameUserProfile,
    );
  }
}
