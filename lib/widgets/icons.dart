import 'package:flutter/material.dart';
import 'package:swap_it/widgets/widgets.dart';

class IconBase extends StatelessWidget {
  final Widget child;

  final Color color;

  final double diameter;

  final void Function() onPressed;

  const IconBase({
    Key? key,
    required final this.child,
    required final this.onPressed,
    this.color = iconBaseColor,
    this.diameter = kIconBaseDiameter,
  }) : super(key: key);

  const IconBase.alternative({
    Key? key,
    required final Widget child,
    required final void Function() onPressed,
  }) : this(
          key: key,
          child: child,
          color: iconBaseAlternativeColor,
          diameter: kIconBaseAlternativeDiameter,
          onPressed: onPressed,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: diameter,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: child,
        backgroundColor: color,
      ),
    );
  }
}
