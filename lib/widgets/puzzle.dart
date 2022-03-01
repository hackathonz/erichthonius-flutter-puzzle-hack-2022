import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

class PuzzleGameTile extends StatelessWidget {
  final PictureTile tile;

  final Size tileSize;

  const PuzzleGameTile({
    Key? key,
    required final this.tile,
    required final this.tileSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: Key('puzzle_game_tile_${tile.id}'),
      borderRadius: const BorderRadius.all(
        Radius.circular(kPictureTileRadius),
      ),
      child: !tile.isEmpty
          ? Image(
              image: tile.imageProvider!,
              fit: BoxFit.cover,
              width: tileSize.width,
              height: tileSize.height,
            )
          : SizedBox.fromSize(
              size: tileSize,
            ),
    );
  }
}

class PuzzleGame extends StatelessWidget {
  final LevelDifficulty difficulty;

  final List<PictureTile> tiles;

  const PuzzleGame({
    Key? key,
    required final this.tiles,
    required final this.difficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tileSize = mapPictureTileSizeForDifficulty(difficulty);

    final tileCount = mapPuzzleGameTileCountForDifficulty(difficulty);

    final crossAxisCount = sqrt(tileCount).floor();

    return GridView.count(
      crossAxisCount: crossAxisCount,
      children: [
        ...tiles.map(
          (x) => PuzzleGameTile(
            tile: x,
            tileSize: tileSize,
          ),
        ),
      ],
      crossAxisSpacing: kPuzzleGameTilesSpacing,
      mainAxisSpacing: kPuzzleGameTilesSpacing,
      primary: false,
    );
  }
}
