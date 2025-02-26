abstract class SettingsDataSource {
  Future<void> set<T>(String settingKey,T value);
  Future<T?> get<T>(String settingKey);
  Future<void> remove(String settingKey); 
}