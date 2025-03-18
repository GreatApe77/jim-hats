import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/cache_service.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/dtos/login_dto.dart';
import 'package:jim_hats_mobile/data/auth/dtos/register_dto.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([SettingsDataSource, AuthDataSource, CacheService])
void main() {
  late AuthRepository sut;
  late SettingsDataSource mockSettingsDataSource;
  late AuthDataSource mockAuthDataSource;
  late CacheService mockCacheService;
  final RegisterDto sampleRegisterDto = RegisterDto(
    username: 'username',
    email: 'email',
    password: 'password',
    profilePicture: 'profilePicture',
  );
  final LoginDto sampleLoginDto = LoginDto(
    username: 'username',
    password: 'password',
  );
  setUp(
    () {
      mockSettingsDataSource = MockSettingsDataSource();
      mockCacheService = MockCacheService();
      mockAuthDataSource = MockAuthDataSource();
      sut = AuthRepository(
        cacheService: mockCacheService,
        settingsDatasource: mockSettingsDataSource,
        authDataSource: mockAuthDataSource,
      );
    },
  );

  group(
    'Register',
    () {
      test(
        'Should register a user',
        () async {
          when(mockAuthDataSource.register(sampleRegisterDto)).thenAnswer(
            (realInvocation) => Future.value(),
          );
          await expectLater(sut.register(sampleRegisterDto), completes);
        },
      );
      test(
        'Should not register a user because data source throws a exception',
        () async {
          when(mockAuthDataSource.register(sampleRegisterDto)).thenAnswer(
            (realInvocation) => throw Exception(),
          );
          await expectLater(sut.register(sampleRegisterDto), throwsException);
        },
      );
    },
  );

  group(
    'Login',
    () {
      test(
        'Should login and return a auth token',
        () async {
          final sampleToken = 'some_token';
          when(mockAuthDataSource.login(sampleLoginDto)).thenAnswer(
            (realInvocation) async => sampleToken,
          );
          when(mockSettingsDataSource.set<String>('token', sampleToken))
              .thenAnswer(
            (realInvocation) async => Future.value(),
          );
          final token = await sut.login(sampleLoginDto);
          await expectLater(token, sampleToken);
        },
      );
      test(
        'Should not login because data source throws',
        () {
          when(mockAuthDataSource.login(sampleLoginDto)).thenAnswer(
            (_) async => throw Exception(),
          );
          expect(sut.login(sampleLoginDto), throwsException);
        },
      );
      test(
        'Should return true if the token is present',
        () async {
          String sampleToken = 'retrieved_token';
          when(mockSettingsDataSource.get<String>('token')).thenAnswer(
            (realInvocation) async => sampleToken,
          );
          final result = await sut.isLoggedIn();
          expect(result, isTrue);
        },
      );
      test(
        'Should return false if token is not present',
        () async {
          when(mockSettingsDataSource.get<String>('token')).thenAnswer(
            (realInvocation) async => null,
          );
          final result = await sut.isLoggedIn();
          expect(result, isFalse);
        },
      );
    },
  );
}
