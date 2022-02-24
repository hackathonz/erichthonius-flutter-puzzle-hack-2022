class GameLevel {
  final String id;

  final LevelDifficulty difficulty;

  const GameLevel({
    required final this.id,
    required final this.difficulty,
  });
}

class GameLevelDifficulty {
  final int pieces;

  final LevelDifficulty difficulty;

  const GameLevelDifficulty({
    required final this.pieces,
    required final this.difficulty,
  });
}

enum LevelDifficulty {
  easy,
  medium,
  hard,
}
