import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

class PuzzleGameTile extends StatelessWidget {
  final PictureTile tile;

  final Size tileSize;

  final void Function() onPressed;

  const PuzzleGameTile({
    Key? key,
    required final this.tile,
    required final this.tileSize,
    required final this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: Key('puzzle_game_tile_${tile.id}'),
      borderRadius: const BorderRadius.all(
        Radius.circular(kPictureTileRadius),
      ),
      child: !tile.isEmpty
          ? GestureDetector(
              child: Image(
                image: tile.imageProvider!,
                fit: BoxFit.cover,
                width: tileSize.width,
                height: tileSize.height,
              ),
              onTap: onPressed,
            )
          : SizedBox.fromSize(
              size: tileSize,
            ),
    );
  }
}

class PuzzleGame extends StatefulWidget {
  final LevelDifficulty difficulty;

  final List<PictureTile> tiles;

  final void Function(List<PuzzleGameTile>) onTileMove;

  const PuzzleGame({
    Key? key,
    required final this.tiles,
    required final this.difficulty,
    required final this.onTileMove,
  }) : super(key: key);

  @override
  State<PuzzleGame> createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  late int crossAxisCount;

  late List<PuzzleGameTile> puzzleTiles;

  @override
  void initState() {
    super.initState();

    puzzleTiles = _mapPictureTilesAsPuzzleGameTiles(widget.tiles);
    crossAxisCount = puzzleTiles.axisCount;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      children: [...puzzleTiles],
      crossAxisSpacing: kPuzzleGameTilesSpacing,
      mainAxisSpacing: kPuzzleGameTilesSpacing,
      primary: false,
    );
  }

  @override
  void didUpdateWidget(covariant PuzzleGame oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.tiles != oldWidget.tiles) {
      setState(
        () {
          puzzleTiles = _mapPictureTilesAsPuzzleGameTiles(widget.tiles);
          crossAxisCount = puzzleTiles.axisCount;
        },
      );
    }
  }

  List<PuzzleGameTile> _mapPictureTilesAsPuzzleGameTiles(
    final List<PictureTile> tiles,
  ) {
    final tileSize = mapPictureTileSizeForDifficulty(widget.difficulty);

    return widget.tiles.map(
      (x) {
        late PuzzleGameTile tile;

        tile = PuzzleGameTile(
          tile: x,
          tileSize: tileSize,
          onPressed: () {
            setState(
              () {
                puzzleTiles.swap(tile);

                widget.onTileMove(puzzleTiles);
              },
            );
          },
        );

        return tile;
      },
    ).toList();
  }
}

///
///    SwapIt!
///  -----------
/// | 0 | 1 | 2 |
/// | 3 | 4 | 5 |
/// | 6 | 7 | B |
///  -----------
///
/// Allowed Moves:
/// > 7 <-> B
/// > 5 <-> B
///
///    SwapIt!
///  -----------
/// | 0 | 1 | 2 |
/// | 3 | B | 5 |
/// | 6 | 7 | 4 |
///  -----------
///
/// Allowed Moves:
///
/// > 1 <-> B
/// > 3 <-> B
/// > 5 <-> B
/// > 7 <-> B
///
extension PuzzleListViewExtension on List<PuzzleGameTile> {
  PuzzleGameTile get emptyTile => firstWhere((x) => x.tile.isEmpty);

  int get axisCount => sqrt(length).floor();

  bool canSwap(final PuzzleGameTile tile) {
    final emptyTileIndex = indexOf(emptyTile);
    final tileIndex = indexOf(tile);
    final _axisCount = axisCount;

    return tileIndex + 1 == emptyTileIndex ||
        tileIndex - 1 == emptyTileIndex ||
        tileIndex + _axisCount == emptyTileIndex ||
        tileIndex - _axisCount == emptyTileIndex;
  }

  void swap(final PuzzleGameTile tile) {
    if (canSwap(tile)) {
      final _emptyTile = emptyTile;

      final tileIndex = indexOf(tile);
      final emptyTileIndex = indexOf(_emptyTile);

      this[tileIndex] = _emptyTile;
      this[emptyTileIndex] = tile;
    }
  }
}
