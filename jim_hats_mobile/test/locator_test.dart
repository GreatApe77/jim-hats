import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/settings/repositories/settings_repository.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'locator_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SettingsRepository>(),
])
void main() {
  late SettingsRepository mockSettingsRepository;

  test(
    'Should load inital settings of settings repository',
    () async {
      mockSettingsRepository = MockSettingsRepository();

      await expectLater(loadSettings(mockSettingsRepository), completes);
      mockito.verify(mockSettingsRepository.loadSettings()).called(1);
    },
  );
}
