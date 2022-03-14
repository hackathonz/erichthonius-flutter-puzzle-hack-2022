import 'dart:math';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/painting.dart';

const _kEasyGameDuration = Duration(minutes: 3);
const _kMediumGameDuration = Duration(minutes: 4);
const _kHardGameDuration = Duration(minutes: 5, seconds: 30);

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

  final GameLevelImage image;

  const GameLevel({
    required final this.id,
    required final this.difficulty,
    required final this.point,
    required final this.image,
  });

  static GameLevel fromJson(
    Map<String, dynamic> json,
    List<GameLevel> levels,
  ) {
    final id = json['id'];

    return levels.firstWhere((x) => x.id == id);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

abstract class GameLevelImage {
  Uint8List get image;
}

class NetworkGameLevelImage extends GameLevelImage {
  final String url;

  Uint8List? _image;

  NetworkGameLevelImage({
    required final this.url,
  });

  Future<void> loadUrl() async {
    if (_image == null) {
      final response = await get(Uri.parse(url));
      _image = response.bodyBytes;
    }
  }

  @override
  Uint8List get image => _image!;
}

class MemoryGameLevelImage extends GameLevelImage {
  final Uint8List _image;

  MemoryGameLevelImage({
    required final Uint8List image,
  }) : _image = image;

  @override
  Uint8List get image => _image;
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

  final DateTime playDateTime;

  final Duration timeTookToFinish;

  final int piecesMoved;

  final int piecesLeftForCompletion;

  const GameLevelPlayEntry({
    required final this.gameLevel,
    required final this.piecesLeftForCompletion,
    required final this.piecesMoved,
    required final this.timeTookToFinish,
    required final this.playDateTime,
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

  static GameLevelPlayEntry fromJson(
    Map<String, dynamic> json,
    List<GameLevel> levels,
  ) {
    return GameLevelPlayEntry(
      gameLevel: GameLevel.fromJson(
        json['gameLevel'],
        levels,
      ),
      playDateTime: DateTime.fromMillisecondsSinceEpoch(
        json['playDateTime'],
      ),
      piecesLeftForCompletion: json['piecesLeftForCompletion'],
      piecesMoved: json['piecesMoved'],
      timeTookToFinish: Duration(
        milliseconds: json['timeTookToFinish'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameLevel': gameLevel.toJson(),
      'playDateTime': playDateTime.toUtc().millisecondsSinceEpoch,
      'timeTookToFinish': timeTookToFinish.inMilliseconds,
      'piecesMoved': piecesMoved,
      'piecesLeftForCompletion': piecesLeftForCompletion,
    };
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
