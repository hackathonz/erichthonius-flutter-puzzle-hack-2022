import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/models/models.dart';
import 'package:image/image.dart';

part 'play_game_level_event.dart';
part 'play_game_level_state.dart';

class PlayGameLevelBloc extends Bloc<PlayGameLevelEvent, PlayGameLevelState> {
  final GameLevel gameLevel;

  final List<PictureTile> gameLevelPictureTiles = [];

  late Timer gameLevelTimer;

  int gameLevelTimeLeftInSeconds;

  PlayGameLevelBloc({
    required final this.gameLevel,
  })  : gameLevelTimeLeftInSeconds =
            gameLevel.difficulty.gameDuration.inSeconds,
        super(PlayGameInitial());

  @override
  Stream<PlayGameLevelState> mapEventToState(PlayGameLevelEvent event) async* {
    if (event is GameLevelStarted) {
      yield* _mapGameLevelStartedToState(event);
    } else if (event is ShuffleGameLevelStarted) {
      yield* _mapShuffleGameLevelStartedToState(event);
    } else if (event is GameLevelTimerUpdated) {
      yield* _mapGameLevelTimerUpdatedToState(event);
    }
  }

  Stream<PlayGameLevelState> _mapGameLevelStartedToState(
    GameLevelStarted event,
  ) async* {
    gameLevelTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        add(
          GameLevelTimerUpdated(),
        );
      },
    );

    gameLevelPictureTiles.addAll(
      _splitPictureInTiles(
        picture: gameLevel.image,
        tileCount: gameLevel.difficulty.pieces,
      ),
    );

    final lastTile = gameLevelPictureTiles.removeLast();

    gameLevelPictureTiles.add(
      PictureTile.empty(
        id: lastTile.id,
      ),
    );

    yield GameLevelInitial(
      difficulty: gameLevel.difficulty.difficulty,
      tiles: [...gameLevelPictureTiles],
    );
  }

  Stream<PlayGameLevelState> _mapShuffleGameLevelStartedToState(
    ShuffleGameLevelStarted event,
  ) async* {
    gameLevelPictureTiles.shuffle();

    yield ShuffleGameSuccess(
      difficulty: gameLevel.difficulty.difficulty,
      tiles: [...gameLevelPictureTiles],
    );
  }

  Stream<PlayGameLevelState> _mapGameLevelTimerUpdatedToState(
    GameLevelTimerUpdated event,
  ) async* {
    gameLevelTimeLeftInSeconds--;

    if (gameLevelTimeLeftInSeconds <= 0) {
      yield GameLevelFinish();

      gameLevelTimer.cancel();
    } else {
      yield GameLevelUpdate(
        timeLeftInSeconds: gameLevelTimeLeftInSeconds,
      );
    }
  }

  List<PictureTile> _splitPictureInTiles({
    required final Uint8List picture,
    required final int tileCount,
  }) {
    final decodedImage = decodeImage(picture);

    final pictureTiles = <PictureTile>[];

    final axisCount = sqrt(tileCount).floor();

    if (decodedImage != null) {
      var x = 0, y = 0;
      final tiles = [];

      final width = (decodedImage.width / axisCount).round();
      final height = (decodedImage.height / axisCount).round();

      for (var i = 0; i < axisCount; i++) {
        for (var j = 0; j < axisCount; j++) {
          tiles.add(
            copyCrop(decodedImage, x, y, width, height),
          );

          x += width;
        }

        x = 0;
        y += height;
      }

      for (var x = 0; x < tiles.length; x++) {
        pictureTiles.add(
          PictureTile(
            id: x,
            imageProvider: MemoryImage(
              Uint8List.fromList(
                encodePng(
                  tiles[x],
                ),
              ),
            ),
          ),
        );
      }
    }

    return pictureTiles;
  }
}
