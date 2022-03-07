import 'package:flutter/material.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kGridTileSpacing = 7.0;

const _kPaddingBetweenLabelAndTiles = EdgeInsets.symmetric(vertical: 4.0);

class GridTile extends StatelessWidget {
  final GridTileData data;

  final void Function() onPressed;

  final bool isSelected;

  const GridTile({
    Key? key,
    required final this.data,
    required final this.onPressed,
    final this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Builder(
          builder: (context) {
            if (data is EmojiGridTileData) {
              return Text(
                (data as EmojiGridTileData).emojiText,
                style: gridTileEmojiTextStyle,
              );
            } else if (data is IconGridTileData) {
              return Icon(
                (data as IconGridTileData).iconData,
                size: kIconGridTileSize,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        constraints: BoxConstraints.tight(kGridTileSize),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: !isSelected ? primaryGridTileColor : alternativeGridTileColor,
          image: data is PhotoGridTileData
              ? DecorationImage(
                  image: NetworkImage(
                    (data as PhotoGridTileData).url,
                  ),
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                )
              : null,
          shape: BoxShape.rectangle,
          border: Border.all(
            color: !isSelected
                ? primaryGridTileBorderColor
                : alternativeGridTileBorderColor,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(
            kGridTileRadius,
          ),
        ),
      ),
      onTap: onPressed,
      borderRadius: BorderRadius.circular(kGridTileRadius),
    );
  }
}

class Grid extends StatelessWidget {
  final String label;

  final List<GridTile> tiles;

  const Grid({
    Key? key,
    required final this.label,
    required final this.tiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: gridTileLabelTextStyle,
        ),
        const Padding(
          padding: _kPaddingBetweenLabelAndTiles,
        ),
        Wrap(
          children: tiles,
          spacing: _kGridTileSpacing,
          runSpacing: _kGridTileSpacing,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}

abstract class GridTileData {}

class EmojiGridTileData extends GridTileData {
  final String emojiText;

  EmojiGridTileData({
    required final this.emojiText,
  });
}

class PhotoGridTileData extends GridTileData {
  final String url;

  PhotoGridTileData({
    required final this.url,
  });
}

class IconGridTileData extends GridTileData {
  final IconData iconData;

  IconGridTileData({
    required final this.iconData,
  });
}
