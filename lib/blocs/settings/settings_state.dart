part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class RetrieveSettingOptionsValuesSuccess extends SettingsState {
  final Map<SettingOption, bool> optionValues;

  RetrieveSettingOptionsValuesSuccess({
    required final this.optionValues,
  });
}

class RetrieveSettingOptionsValuesFailure extends SettingsState {}

class SettingOptionValueUpdateSuccess extends SettingsState {}

class SettingOptionValueUpdateFailure extends SettingsState {}
