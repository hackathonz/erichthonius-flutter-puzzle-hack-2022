import 'package:flutter/material.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/views/views.dart';

Future<void> navigateToChooseDifficultyView(final BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return const ChooseDifficultyView();
      },
    ),
  );
}

Future<void> navigateToChooseLevelView(
  final BuildContext context,
  final GameLevelDifficulty gameLevelDifficulty,
) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return ChooseLevelView(
          gameLevelDifficulty: gameLevelDifficulty,
        );
      },
    ),
  );
}

Future<void> navigateToPlayGameView(
  final BuildContext context,
  final GameLevel gameLevel,
) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return PlayGameView(
          gameLevel: gameLevel,
        );
      },
    ),
  );
}

Future<void> navigateToSettingsView(final BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return const SettingsView();
      },
    ),
  );
}
