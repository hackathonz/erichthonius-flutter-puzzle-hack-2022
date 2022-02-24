export 'colors.dart';
export 'images.dart';
export 'sizes.dart';
export 'buttons.dart';
export 'typography.dart';

import 'package:flutter/material.dart';
import 'package:swap_it/widgets/colors.dart';
import 'package:swap_it/widgets/sizes.dart';

class IconBase extends StatelessWidget {
  final Widget child;

  final Color color;

  final double diameter;

  const IconBase({
    Key? key,
    required final this.child,
    this.color = iconBaseColor,
    this.diameter = kIconBaseDiameter,
  }) : super(key: key);

  const IconBase.alternative({
    Key? key,
    required final Widget child,
  }) : this(
          key: key,
          child: child,
          color: iconBaseAlternativeColor,
          diameter: kIconBaseAlternativeDiameter,
        );

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: child,
      radius: diameter / 2.0,
      backgroundColor: color,
    );
  }
}
