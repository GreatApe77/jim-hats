import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:jim_hats_mobile/data/settings/models/settings.dart';
import 'package:jim_hats_mobile/locator.dart';

class SettingsRepository {
  late Settings _settings;
  final SettingsDataSource _settingsDataSource;

  Settings get settings => _settings;
  SettingsRepository({
    required SettingsDataSource settingsDataSource,
  }) : _settingsDataSource = settingsDataSource;
  Future<void> loadSettings() async {
    final isDarkTheme = await _settingsDataSource.get<bool>('isDarkTheme');

    _settings = Settings(isDarkTheme: isDarkTheme ?? false);
  }

  Future<void> setIsDarkTheme(bool isDarkTheme) async {
    _settings.isDarkTheme = isDarkTheme;
    await _settingsDataSource.set<bool>('isDarkTheme', isDarkTheme);
  }
}
