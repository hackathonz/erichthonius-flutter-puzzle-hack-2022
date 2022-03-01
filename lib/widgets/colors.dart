import 'package:flutter/material.dart';
import 'package:swap_it/models/models.dart';

const backgroundGradient = RadialGradient(
  colors: [
    Color(0xFF4448E8),
    Color(0xFF6063F2),
  ],
  stops: [0.0, 1.0],
);

const backgroundDecoration = BoxDecoration(
  gradient: backgroundGradient,
);

const iconsColor = Color(0xFFFFFFFF);
const iconBaseColor = Color(0xFF4447CA);
const iconBaseAlternativeColor = Color(0xFFEBCD17);

const primaryTextColor = Color(0xFFFFFFFF);
const primaryLightTextColor = Color(0xFFDDDDDD);
const alertTextColor = Color(0xFFFA4C2B);
const primaryButtonColor = Color(0xFF4447CA);
const primaryCardColor = Color(0xFF4447CA);
const primaryCardShadowColor = Color(0x20000000);

const kListTileColor = Color(0xFF4447CA);

const listTileBoxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
  offset: Offset(0.0, 2.0),
  blurRadius: 20.0,
);

const levelMarkerBoxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
  offset: Offset(0.0, 2.0),
  blurRadius: 22.0,
);

const switchActiveColor = Color(0x66D2D3FF);
const switchTrackColor = Color(0x66000000);

const easyLevelMarkerColor = Color(0xFF7ED5DD);
const mediumLevelMarkerColor = Color(0xFFE8E768);
const hardLevelMarkerColor = Color(0xFFE7B277);

const levelMarkerBorderColor = Color(0xFFFFFFFF);

Color mapColorForDifficulty(final LevelDifficulty difficulty) {
  switch (difficulty) {
    case LevelDifficulty.easy:
      return easyLevelMarkerColor;
    case LevelDifficulty.medium:
      return mediumLevelMarkerColor;
    case LevelDifficulty.hard:
      return hardLevelMarkerColor;
  }
}
