part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class RetrieveSettingOptionsValuesStarted extends SettingsEvent {}

class SettingOptionValueUpdated extends SettingsEvent {
  final SettingOption option;

  final bool value;

  SettingOptionValueUpdated({
    required final this.option,
    required final this.value,
  });
}
