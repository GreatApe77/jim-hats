import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/settings_page/settings_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'setting_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UploadRepository>(),
  MockSpec<LoggedUserRepository>(),
])
void main() {
  late SettingsCubit sut;
  late MockLoggedUserRepository mockLoggedUserRepository;
  late MockUploadRepository mockUploadRepository;
  final sampleUploadedUrl = 'https://url';
  final sampleLoggedUser = LoggedUser(
    id: 5,
    username: 'mateus',
    email: 'mateus@email.com',
  );
  setUp(
    () {
      mockUploadRepository = MockUploadRepository();
      mockLoggedUserRepository = MockLoggedUserRepository();
      sut = SettingsCubit(
        uploadRepository: mockUploadRepository,
        loggedUserRepository: mockLoggedUserRepository,
      );
    },
  );
  test(
    'Should start with initial state',
    () {
      expect(sut.state, isA<SettingsInitial>());
    },
  );
  blocTest<SettingsCubit, SettingsState>(
    'Should load settings data',
    setUp: () {
      when(
        mockLoggedUserRepository.getLoggedUser(),
      ).thenAnswer(
        (_) async => sampleLoggedUser,
      );
    },
    build: () => sut,
    act: (cubit) => cubit.loadSettingsData(),
    expect: () => [
      isA<SettingsDataLoadInProgress>(),
      isA<SettingsDataLoadSuccess>().having(
        (state) => state.loggedUser.username,
        'Logged username',
        'mateus',
      ),
    ],
  );
  blocTest<SettingsCubit, SettingsState>(
    'Should Update profile picture to other image',
    setUp: () {
      when(
        mockUploadRepository.uploadFile(any),
      ).thenAnswer(
        (_) async => sampleUploadedUrl,
      );
      when(mockLoggedUserRepository.updateLoggedUser(any)).thenAnswer(
        (_) async => sampleLoggedUser.copyWith(
          profilePicture: sampleUploadedUrl,
        ),
      );
    },
    build: () => sut,
    act: (cubit) => cubit.updateLoggedUserProfilePicture(
      XFile(''),
    ),
    expect: () => [
      isA<SettingsDataLoadInProgress>(),
      isA<SettingsDataLoadSuccess>().having(
        (state) => state.loggedUser.profilePicture,
        'Updated profile picture',
        sampleUploadedUrl,
      ),
    ],
  );
  blocTest<SettingsCubit, SettingsState>(
    'Should Update profile picture to null image',
    setUp: () {
      when(mockLoggedUserRepository.updateLoggedUser(any)).thenAnswer(
        (_) async => sampleLoggedUser.copyWith(
          profilePicture: null,
        ),
      );
    },
    build: () => sut,
    verify: (_) {
      verifyZeroInteractions(mockUploadRepository);
    },
    act: (cubit) => cubit.updateLoggedUserProfilePicture(
      null,
    ),
    expect: () => [
      isA<SettingsDataLoadInProgress>(),
      isA<SettingsDataLoadSuccess>().having(
        (state) => state.loggedUser.profilePicture,
        'Updated profile picture',
        isNull,
      ),
    ],
  );
  blocTest<SettingsCubit, SettingsState>(
    'Should handle exception while updating profile picture',
    setUp: () {
      when(
        mockLoggedUserRepository.updateLoggedUser(any),
      ).thenThrow(
        Error(),
      );
    },
    build: () => sut,
    verify: (_) {
      verifyZeroInteractions(mockUploadRepository);
    },
    act: (cubit) => cubit.updateLoggedUserProfilePicture(
      null,
    ),
    expect: () =>
        [isA<SettingsDataLoadInProgress>(), isA<SettingsDataFailed>()],
  );
}
