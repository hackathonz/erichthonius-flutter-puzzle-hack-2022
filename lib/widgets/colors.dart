import 'package:flutter/material.dart';

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
const primaryButtonColor = Color(0xFF4447CA);
const primaryCardColor = Color(0xFF4447CA);
const primaryCardShadowColor = Color(0x20000000);
