import 'package:flutter/material.dart';
import 'package:swap_it/widgets/widgets.dart';

class IconBase extends StatelessWidget {
  final Widget child;

  final Color color;

  final double diameter;

  final void Function() onPressed;

  const IconBase({
    required final Key key,
    required final this.child,
    required final this.onPressed,
    this.color = iconBaseColor,
    this.diameter = kIconBaseDiameter,
  }) : super(key: key);

  const IconBase.alternative({
    required final Key key,
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
        heroTag: Key('IconBase_FloatingActionButton_$key'),
        onPressed: onPressed,
        child: child,
        backgroundColor: color,
      ),
    );
  }
}

class SwapItIcons {
  static const String _fontFamily = 'icomoon';

 static const IconData add = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData back = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData chevron = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData close = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData cup = IconData(0xe904, fontFamily: _fontFamily);
  static const IconData heart = IconData(0xe905, fontFamily: _fontFamily);
  static const IconData help = IconData(0xe906, fontFamily: _fontFamily);
  static const IconData lock = IconData(0xe907, fontFamily: _fontFamily);
  static const IconData pencil = IconData(0xe908, fontFamily: _fontFamily);
  static const IconData profile = IconData(0xe909, fontFamily: _fontFamily);
  static const IconData puzzle = IconData(0xe90a, fontFamily: _fontFamily);
  static const IconData settings = IconData(0xe90b, fontFamily: _fontFamily);
  static const IconData star = IconData(0xe90c, fontFamily: _fontFamily);
  static const IconData stargrey = IconData(0xe90d, fontFamily: _fontFamily);
}
