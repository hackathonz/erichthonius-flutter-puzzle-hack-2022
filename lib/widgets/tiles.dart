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
