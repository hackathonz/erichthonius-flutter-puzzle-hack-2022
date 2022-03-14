import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/logging/logging.dart';
import 'package:swap_it/models/models.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final Map<SettingOption, bool> optionValues = {};

  final SettingsRepository settingsRepository;

  SettingsBloc({
    required final this.settingsRepository,
  }) : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is RetrieveSettingOptionsValuesStarted) {
      yield* _mapRetrieveSettingOptionsValuesStartedToState(event);
    } else if (event is SettingOptionValueUpdated) {
      yield* _mapSettingOptionValueUpdatedToState(event);
    }
  }

  Stream<SettingsState> _mapRetrieveSettingOptionsValuesStartedToState(
    RetrieveSettingOptionsValuesStarted event,
  ) async* {
    try {
      final _optionValues = await settingsRepository.options();

      optionValues.addAll(_optionValues);

      yield RetrieveSettingOptionsValuesSuccess(
        optionValues: optionValues,
      );
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield RetrieveSettingOptionsValuesFailure();
    }
  }

  Stream<SettingsState> _mapSettingOptionValueUpdatedToState(
    SettingOptionValueUpdated event,
  ) async* {
    try {
      await settingsRepository.updateOption(
        option: event.option,
        value: event.value,
      );

      optionValues[event.option] = event.value;

      yield SettingOptionValueUpdateSuccess();

      yield RetrieveSettingOptionsValuesSuccess(
        optionValues: optionValues,
      );
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield SettingOptionValueUpdateFailure();
    }
  }
}
