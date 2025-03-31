import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:jim_hats_mobile/data/settings/models/settings.dart';
import 'package:jim_hats_mobile/data/settings/repositories/settings_repository.dart';
import 'package:meta/meta.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'settings_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SettingsDataSource>(),
])
void main() {
  late SettingsRepository sut;
  late MockSettingsDataSource mockSettingsDataSource;
  setUp(
    () {
      mockSettingsDataSource = MockSettingsDataSource();
      sut = SettingsRepository(settingsDataSource: mockSettingsDataSource);
    },
  );
  test(
    'Should load settings',
    () async {
      when(mockSettingsDataSource.get<bool>(any)).thenAnswer(
        (realInvocation) async => true,
      );

      await sut.loadSettings();
      expect(
        sut.settings,
        isA<Settings>().having(
          (state) => state.isDarkTheme,
          'Is dark theme',
          isTrue,
        ),
      );
    },
  );
   test(
    'Should set isDarkTheme to false',
    () async {
      await sut.loadSettings();
      await sut.setIsDarkTheme(false);
      expect(sut.settings.isDarkTheme, isFalse);
      
    },
  );
}
