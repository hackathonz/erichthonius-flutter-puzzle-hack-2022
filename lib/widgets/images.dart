import 'package:flutter/material.dart';

const _kSwapItLogoAssetPath = 'assets/images/swap_it_logo.png';
const _kSwapItAlternativeLogoAssetPath =
    'assets/images/swap_it_alternative_logo.png';

class SwapItLogo extends StatelessWidget {
  const SwapItLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
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
    return Image.asset(
      _kSwapItAlternativeLogoAssetPath,
    );
  }
}
