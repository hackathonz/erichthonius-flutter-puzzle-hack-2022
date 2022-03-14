import 'package:shared_preferences/shared_preferences.dart';
import 'package:swap_it/models/models.dart';
import 'package:uuid/uuid.dart';

abstract class SettingsRepository {
  Future<Map<SettingOption, bool>> options();

  Future<void> updateOption({
    required final SettingOption option,
    required final bool value,
  });

  Future<String> get deviceId;
}

class RealSettingsRepository extends SettingsRepository {
  final Map<SettingOption, bool> _cacheOptions = {};

  final SharedPreferences preferences;

  RealSettingsRepository({
    required final this.preferences,
  });

  @override
  Future<Map<SettingOption, bool>> options() {
    if (_cacheOptions.isEmpty) {
      for (var x in SettingOption.values) {
        _cacheOptions[x] = preferences.getBool(x.toString()) ?? true;
      }
    }
    return Future.value(_cacheOptions);
  }

  @override
  Future<void> updateOption({
    required SettingOption option,
    required bool value,
  }) {
    return preferences.setBool(option.toString(), value);
  }

  @override
  Future<String> get deviceId async {
    var storedDeviceId = preferences.getString('device-id');

    if (storedDeviceId == null) {
      storedDeviceId = const Uuid().v4();
      await preferences.setString('device-id', storedDeviceId);
    }

    return storedDeviceId;
  }
}

class MockSettingsRepository extends SettingsRepository {
  final _options = {
    SettingOption.notifications: true,
    SettingOption.sounds: true,
    SettingOption.vibration: false,
  };

  @override
  Future<Map<SettingOption, bool>> options() {
    return Future.value(_options);
  }

  @override
  Future<void> updateOption({
    required SettingOption option,
    required bool value,
  }) {
    _options[option] = value;

    return Future.value();
  }

  @override
  Future<String> get deviceId => Future.value('device-id');
}
