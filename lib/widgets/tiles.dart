import 'package:flutter/material.dart';
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
