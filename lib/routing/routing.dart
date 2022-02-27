import 'package:flutter/material.dart';
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

Future<void> navigateToChooseLevelView(final BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return const ChooseLevelView();
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
