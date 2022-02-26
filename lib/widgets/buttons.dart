import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kButtonMinSize = Size(247.0, 48.0);
const _kButtonRadius = Radius.circular(24.0);

class SwapItButton extends StatelessWidget {
  final Text text;

  final Color color;

  final Size size;

  final void Function() onPressed;

  SwapItButton({
    Key? key,
    required final this.onPressed,
    required final String text,
  })  : text = Text(
          text,
          style: primaryButtonTextStyle,
          textAlign: TextAlign.center,
        ),
        color = primaryButtonColor,
        size = _kButtonMinSize,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: text,
      color: color,
      minWidth: size.width,
      height: size.height,
      onPressed: onPressed,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(_kButtonRadius),
        side: BorderSide.none,
      ),
    );
  }
}

class SwapItSwitchButton extends StatelessWidget {
  final bool initalValue;

  final void Function(bool) onChanged;

  const SwapItSwitchButton({
    Key? key,
    required final this.onChanged,
    final this.initalValue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value = initalValue;

    return StatefulBuilder(
      builder: (context, setState) {
        return FlutterSwitch(
          value: value,
          onToggle: (_value) {
            setState(
              () {
                value = _value;
              },
            );

            onChanged(_value);
          },
          activeColor: switchActiveColor,
          inactiveColor: switchTrackColor,
          width: kSwitchWidth,
          toggleSize: kSwitchToggleSize,
        );
      },
    );
  }
}
