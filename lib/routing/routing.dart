import 'package:flutter/material.dart';
import 'package:swap_it/views/views.dart';

Future<void> navigateToPlayGameView(final BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return const ChooseDifficultyView();
      },
    ),
  );
}
