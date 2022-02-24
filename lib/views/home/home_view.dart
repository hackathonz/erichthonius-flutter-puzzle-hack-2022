import 'package:flutter/material.dart';
import 'package:swap_it/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          const SwapItAlternativeLogo(),
          const Icon(
            Icons.play_arrow_outlined,
            size: 96.0,
          ),
          Row(
            children: const [
              IconBase(
                child: Icon(
                  Icons.help_outline,
                  size: 32.0,
                ),
              ),
              IconBase.alternative(
                child: Icon(
                  Icons.help_outline,
                  size: 32.0,
                ),
              ),
              IconBase(
                child: Icon(
                  Icons.settings,
                  size: 32.0,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
        primary: false,
      ),
    );
  }
}
