import 'package:flutter/material.dart';
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
