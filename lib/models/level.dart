import 'dart:math';

import 'package:flutter/painting.dart';

class GameLevel {
  final String id;

  final LevelDifficulty difficulty;

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
