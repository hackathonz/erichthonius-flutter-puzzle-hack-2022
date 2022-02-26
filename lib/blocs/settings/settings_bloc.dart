import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/models/models.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final Map<SettingOption, bool> optionValues = {};

  SettingsBloc() : super(SettingsInitial());

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
    optionValues[SettingOption.notifications] = true;
    optionValues[SettingOption.sounds] = true;
    optionValues[SettingOption.vibration] = false;

    yield RetrieveSettingOptionsValuesSuccess(
      optionValues: optionValues,
    );
  }

  Stream<SettingsState> _mapSettingOptionValueUpdatedToState(
    SettingOptionValueUpdated event,
  ) async* {
    optionValues[event.option] = event.value;

    yield SettingOptionValueUpdateSuccess();

    yield RetrieveSettingOptionsValuesSuccess(
      optionValues: optionValues,
    );
  }
}
