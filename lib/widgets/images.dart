import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swap_it/models/level.dart';

const _kSwapItLogoAssetPath = 'assets/images/swap_it_logo.svg';
const _kSwapItAlternativeLogoAssetPath =
    'assets/images/swap_it_alternative_logo.svg';
const _kEasyMapAssetPath = 'assets/images/easy_map.svg';
const _kMediumMapAssetPath = 'assets/images/medium_map.svg';
const _kHardMapAssetPath = 'assets/images/hard_map.svg';

class SwapItLogo extends StatelessWidget {
  const SwapItLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _kSwapItLogoAssetPath,
    );
  }
}

class SwapItAlternativeLogo extends StatelessWidget {
  const SwapItAlternativeLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _kSwapItAlternativeLogoAssetPath,
    );
  }
}

class EasyMapPreview extends StatelessWidget {
  const EasyMapPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _kEasyMapAssetPath,
    );
  }
}

class MediumMapPreview extends StatelessWidget {
  const MediumMapPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _kMediumMapAssetPath,
    );
  }
}

class HardMapPreview extends StatelessWidget {
  const HardMapPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _kHardMapAssetPath,
    );
  }
}

Widget mapPreviewForDifficulty(final LevelDifficulty difficulty) {
  switch (difficulty) {
    case LevelDifficulty.easy:
      return const EasyMapPreview();
    case LevelDifficulty.medium:
      return const MediumMapPreview();
    case LevelDifficulty.hard:
      return const HardMapPreview();
  }
}
