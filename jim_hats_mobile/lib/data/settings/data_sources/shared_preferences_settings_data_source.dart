import 'package:shared_preferences/shared_preferences.dart';
import 'settings_data_source.dart';

class SharedPreferencesSettingsDataSource implements SettingsDataSource {
  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  @override
  Future<T?> get<T>(String settingKey) async {
    final sh = await _prefs;

    if (T == String) {
      return sh.getString(settingKey) as T?;
    } else if (T == int) {
      return sh.getInt(settingKey) as T?;
    } else if (T == double) {
      return sh.getDouble(settingKey) as T?;
    } else if (T == bool) {
      return sh.getBool(settingKey) as T?;
    } else if (T == List<String>) {
      return sh.getStringList(settingKey) as T?;
    } else {
      throw UnsupportedError("Type $T is not supported by SharedPreferences");
    }
  }

  @override
  Future<void> set<T>(String settingKey, T value) async {
    final sh = await _prefs;

    if (value is String) {
      await sh.setString(settingKey, value);
    } else if (value is int) {
      await sh.setInt(settingKey, value);
    } else if (value is double) {
      await sh.setDouble(settingKey, value);
    } else if (value is bool) {
      await sh.setBool(settingKey, value);
    } else if (value is List<String>) {
      await sh.setStringList(settingKey, value);
    } else {
      throw UnsupportedError("Type ${value.runtimeType} is not supported by SharedPreferences");
    }
  }

  
  @override
  Future<void> remove(String settingKey) async {
    final sh = await _prefs;
    await sh.remove(settingKey);
  }

  
  Future<void> clear() async {
    final sh = await _prefs;
    await sh.clear();
  }
}