import 'dart:math';

import 'package:flutter/painting.dart';

const _kEasyGameDuration = Duration(minutes: 3);
const _kMediumGameDuration = Duration(minutes: 2);
const _kHardGameDuration = Duration(minutes: 1, seconds: 30);

const kGameLevelEasyDifficulty = GameLevelDifficulty(
  difficulty: LevelDifficulty.easy,
  pieces: 9,
);

const kGameLevelMediumDifficulty = GameLevelDifficulty(
  difficulty: LevelDifficulty.medium,
  pieces: 16,
);

const kGameLevelHardDifficulty = GameLevelDifficulty(
  difficulty: LevelDifficulty.hard,
  pieces: 25,
);

class GameLevel {
  final String id;

  final GameLevelDifficulty difficulty;

  final LevelMarkerPoint point;

  const GameLevel({
    required final this.id,
    required final this.difficulty,
    required final this.point,
  });
}

class GameLevelDifficulty {
  final int pieces;

  final LevelDifficulty difficulty;

  const GameLevelDifficulty({
    required final this.pieces,
    required final this.difficulty,
  });

  int get rewardingPoints => pieces * (difficulty.index + 1) * 100;

  Duration get gameDuration {
    switch (difficulty) {
      case LevelDifficulty.easy:
        return _kEasyGameDuration;
      case LevelDifficulty.medium:
        return _kMediumGameDuration;
      case LevelDifficulty.hard:
      default:
        return _kHardGameDuration;
    }
  }
}

class GameLevelPlayEntry {
  final GameLevel gameLevel;

  final Duration timeTookToFinish;

  final int piecesMoved;

  final int piecesLeftForCompletion;

  const GameLevelPlayEntry({
    required final this.gameLevel,
    required final this.piecesLeftForCompletion,
    required final this.piecesMoved,
    required final this.timeTookToFinish,
  });

  bool get hasCompletedLevel => piecesLeftForCompletion == 0;

  int get pointsObtained =>
      gameLevel.difficulty.rewardingPoints *
      ((gameLevel.difficulty.gameDuration - timeTookToFinish).inSeconds * 0.2)
          .toInt();

  int get starsAchieved {
    if (!hasCompletedLevel) {
      return 0;
    }

    final scoreRatio = gameLevel.difficulty.gameDuration.inSeconds /
        timeTookToFinish.inSeconds;

    if (scoreRatio < 0.3) {
      return 1;
    } else if (scoreRatio < 0.5) {
      return 2;
    } else {
      return 3;
    }
  }
}

enum LevelDifficulty {
  easy,
  medium,
  hard,
}

class LevelMarkerPoint extends Point {
  final Size mapSize;

  const LevelMarkerPoint({
    required final this.mapSize,
    required final num x,
    required final num y,
  }) : super(x, y);

  Point onDifferentMapSize(final Size targetMapSize) {
    return Point(
      (mapSize.width * 27.5) / targetMapSize.width,
      (mapSize.height * 80.0) / targetMapSize.height,
    );
  }
}

GameLevelDifficulty mapGameLevelDifficultyForLevelDifficulty(
  final LevelDifficulty difficulty,
) {
  switch (difficulty) {
    case LevelDifficulty.easy:
      return kGameLevelEasyDifficulty;
    case LevelDifficulty.medium:
      return kGameLevelMediumDifficulty;
    case LevelDifficulty.hard:
    default:
      return kGameLevelHardDifficulty;
  }
}
