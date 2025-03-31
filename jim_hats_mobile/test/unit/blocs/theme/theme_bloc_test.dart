import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/settings/repositories/settings_repository.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SettingsRepository>()])
void main() {
  late SettingsRepository mockSettingsRepository;
  late ThemeBloc sut;
  setUp(
    () {
      mockSettingsRepository = MockSettingsRepository();
      sut = ThemeBloc(
        settingsRepository: mockSettingsRepository,
        themeState: ThemeLight(),
      );
    },
  );

  test(
    'Inital state must be dark',
    () {
      final customSut = ThemeBloc(
          settingsRepository: mockSettingsRepository, themeState: ThemeDark());
      expect(customSut.state, isA<ThemeDark>());
    },
  );
  test(
    'Initial state must be light',
    () {
      expect(sut.state, isA<ThemeLight>());
    },
  );
  blocTest<ThemeBloc, ThemeState>(
    'Should change to dark theme',
    build: () => sut,
    act: (bloc) => bloc.add(ThemeToggledEvent()),
    verify: (_) {
      verify(mockSettingsRepository.setIsDarkTheme(true)).called(1);
    },
    expect: () => [isA<ThemeDark>()],
  );
  blocTest<ThemeBloc, ThemeState>(
    'Should change to dark theme and then switch back to light theme',
    build: () => sut,
    act: (bloc) async {
      await () async {
        bloc.add(ThemeToggledEvent());
      }();
      await () async {
        bloc.add(ThemeToggledEvent());
      }();
    },
    verify: (_) {
      verify(mockSettingsRepository.setIsDarkTheme(true)).called(1);
      verify(mockSettingsRepository.setIsDarkTheme(false)).called(1);
    },
    expect: () => [isA<ThemeDark>(), isA<ThemeLight>()],
  );
}
