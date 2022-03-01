import 'package:flutter/material.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kSwitchListTilePadding = EdgeInsets.symmetric(
  horizontal: 16.0,
);

class SwapItSwitchListTile extends StatelessWidget {
  final String leading;

  final bool switchInitialValue;

  final void Function(bool) onSwitchValueChange;

  const SwapItSwitchListTile({
    Key? key,
    required final this.leading,
    required final this.switchInitialValue,
    required final this.onSwitchValueChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kListTileSize.width,
      height: kListTileSize.height,
      padding: _kSwitchListTilePadding,
      child: Row(
        children: [
          Text(
            leading,
            style: listTileLeadingTextStyle,
            textAlign: TextAlign.center,
          ),
          SwapItSwitchButton(
            initalValue: switchInitialValue,
            onChanged: onSwitchValueChange,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          kListTileRadius,
        ),
        boxShadow: const [
          listTileBoxShadow,
        ],
        color: kListTileColor,
      ),
    );
  }
}

class LevelMarker extends StatelessWidget {
  final GameLevel level;

  final void Function() onPressed;

  final bool isLocked;

  const LevelMarker({
    Key? key,
    required final this.level,
    required final this.onPressed,
    final this.isLocked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox.fromSize(
        size: kLevelMarkerSize,
        child: Stack(
          children: <Widget>[
            Container(
              width: kLevelMarkerSize.width,
              height: kLevelMarkerSize.height,
              decoration: BoxDecoration(
                boxShadow: const [
                  levelMarkerBoxShadow,
                ],
                color: mapColorForDifficulty(
                  level.difficulty.difficulty,
                ),
                border: Border.all(
                  color: levelMarkerBorderColor,
                  width: kLevelMarkerBorderThickness,
                ),
                borderRadius: BorderRadius.circular(
                  kLevelMarkerRadius,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: !isLocked
                  ? Text(
                      level.id,
                      textAlign: TextAlign.center,
                      style: levelMarkerTextStyle,
                    )
                  : const Icon(
                      SwapItIcons.lock,
                      size: kIconLevelMarkerSize,
                    ),
            ),
          ],
        ),
      ),
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
    );
  }
}

// class GameLevelPicturePainter extends CustomPainter {
//   final List<PictureTile> tiles;
//   final PictureTile hitNode;

//   final double downX, downY, newX, newY;
//   final List<PictureTile> hitNodeList;
//   TileMoveDirection direction;

//   final bool needDraw;

//   GameLevelPicturePainter({
//     required final this.direction,
//     required final this.downX,
//     required final this.downY,
//     required final this.hitNode,
//     required final this.hitNodeList,
//     required final this.needDraw,
//     required final this.newX,
//     required final this.newY,
//     required final this.tiles,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (var i = 0; i < tiles.length; ++i) {
//       PictureTile tile = tiles[i];

//       Rect rect2 = Rect.fromLTRB(
//         tile.rect.left,
//         tile.rect.top,
//         tile.rect.right,
//         tile.rect.bottom,
//       );

//       if (hitNodeList.contains(tile)) {
//         if (direction == TileMoveDirection.left ||
//             direction == TileMoveDirection.right) {
//           rect2 = tile.rect.shift(Offset(newX - downX, 0.0));
//         } else if (direction == TileMoveDirection.top ||
//             direction == TileMoveDirection.bottom) {
//           rect2 = tile.rect.shift(Offset(0.0, newY - downY));
//         }
//       }

//       Rect srcRect = Rect.fromLTRB(
//         0.0,
//         0.0,
//         tile.image.width.toDouble(),
//         tile.image.height.toDouble(),
//       );

//       canvas.drawImageRect(tiles[i].image, srcRect, rect2, Paint());
//     }

//     for (var i = 0; i < tiles.length; ++i) {
//       PictureTile tile = tiles[i];

//       final pb = ui.ParagraphBuilder(
//         ui.ParagraphStyle(
//           textAlign: TextAlign.center,
//           fontWeight: FontWeight.w300,
//           fontStyle: FontStyle.normal,
//           fontSize: hitNode == tile ? 20.0 : 15.0,
//         ),
//       );

//       if (hitNode == tile) {
//         pb.pushStyle(ui.TextStyle(color: Color(0xff00ff00)));
//       }

//       pb.addText('${tile.index + 1}');

//       ui.ParagraphConstraints pc =
//           ui.ParagraphConstraints(width: tile.rect.width);
//       ui.Paragraph paragraph = pb.build()..layout(pc);

//       var offset = Offset(
//         tile.rect.left,
//         tile.rect.top + tile.rect.height / 2 - paragraph.height / 2,
//       );

//       if (hitNodeList.contains(tile)) {
//         if (direction == TileMoveDirection.left ||
//             direction == TileMoveDirection.right) {
//           offset = Offset(
//             offset.dx + newX - downX,
//             offset.dy,
//           );
//         } else if (direction == TileMoveDirection.top ||
//             direction == TileMoveDirection.bottom) {
//           offset = Offset(
//             offset.dx,
//             offset.dy + newY - downY,
//           );
//         }
//       }

//       canvas.drawParagraph(paragraph, offset);
//     }
//   }

//   @override
//   bool shouldRepaint(GameLevelPicturePainter oldDelegate) {
//     return needDraw || oldDelegate.needDraw;
//   }
// }

// enum TileMoveDirection {
//   none,
//   left,
//   right,
//   top,
//   bottom,
// }

// class PictureTile {
//   final int curIndex;
//   final int index;
//   final Path path;
//   final Rect rect;
//   final ui.Image image;

//   PictureTile({
//     required final this.curIndex,
//     required final this.image,
//     required final this.index,
//     required final this.path,
//     required final this.rect,
//   });
// }

// class PictureTileBuilder {
//   late int curIndex;

//   late int index;

//   late Path path;

//   late Rect rect;

//   late ui.Image image;

//   void withCurIndex(final int curIndex) {
//     this.curIndex = curIndex;
//   }

//   void withIndex(final int index) {
//     this.index = index;
//   }

//   void withPath(final Path path) {
//     this.path = path;
//   }

//   void withRect(final Rect rect) {
//     this.rect = rect;
//   }

//   void withImage(final ui.Image image) {
//     this.image = image;
//   }

//   PictureTile build() {
//     return PictureTile(
//       curIndex: curIndex,
//       image: image,
//       index: index,
//       path: path,
//       rect: rect,
//     );
//   }
// }
