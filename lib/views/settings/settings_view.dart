import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kListViewPadding = EdgeInsets.symmetric(
  vertical: 24.0,
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

    final settingsBloc = context.read<SettingsBloc>();

    final settingOptions = [
      MapEntry(
        SettingOption.notifications,
        localizations.notificationsOption,
      ),
      MapEntry(
        SettingOption.sounds,
        localizations.soundsOption,
      ),
      MapEntry(
        SettingOption.vibration,
        localizations.vibrationOption,
      ),
    ];

    return SwapItScaffold(
      appBar: SwapItAppBar(
        title: localizations.settingsTitle,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) =>
            current is RetrieveSettingOptionsValuesSuccess,
        builder: (context, state) {
          final optionValues = state is RetrieveSettingOptionsValuesSuccess
              ? state.optionValues
              : settingsBloc.optionValues;

          return ListView.separated(
            itemBuilder: (context, index) => SwapItSwitchListTile(
              leading: settingOptions[index].value,
              switchInitialValue:
                  optionValues[settingOptions[index].key] ?? false,
              onSwitchValueChange: (value) {
                settingsBloc.add(
                  SettingOptionValueUpdated(
                    option: settingOptions[index].key,
                    value: value,
                  ),
                );
              },
            ),
            separatorBuilder: (context, index) => const Padding(
              padding: _kSeparatorPadding,
            ),
            itemCount: settingOptions.length,
            padding: _kListViewPadding,
            primary: false,
          );
        },
      ),
    );
  }
}
