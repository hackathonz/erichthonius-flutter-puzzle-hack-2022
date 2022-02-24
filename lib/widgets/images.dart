import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _kSwapItLogoAssetPath = 'assets/images/swap_it_logo.svg';
const _kSwapItAlternativeLogoAssetPath =
    'assets/images/swap_it_alternative_logo.svg';

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
