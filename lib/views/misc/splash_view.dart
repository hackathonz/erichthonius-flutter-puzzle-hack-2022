import 'package:flutter/material.dart';
import 'package:swap_it/widgets/widgets.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SwapItLogo(),
    );
  }
}
