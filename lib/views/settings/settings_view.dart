import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kAppbarTitleInBetweenPadding = EdgeInsets.symmetric(
  vertical: 5.0,
);

const _kListViewPadding = EdgeInsets.symmetric(
  vertical: 16.0,
);

const _kSeparatorPadding = EdgeInsets.symmetric(
  vertical: 8.0,
);

class SettingsView extends StatelessWidget {
  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SwapItScaffold(
      appBar: SwapItAppBar(
        title: localizations.settingsTitle,
      ),
      body: ListView(),
    );
  }
}
