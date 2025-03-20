import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/cache_service.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/dtos/update_logged_user_dto.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logged_user_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoggedUserDataSource>(), MockSpec<CacheService>()])
void main() {
  late LoggedUserRepository sut;
  late LoggedUserDataSource mockLoggedUserDataSource;
  late CacheService mockCacheService;
  final sampleUpdateLoggedUserDto = UpdateLoggedUserDto(
    profilePicture: 'https://image.com',
  );
  final sampleLoggedUser = LoggedUser(
    id: 3,
    username: 'username',
    email: 'email',
  );

  setUp(
    () {
      mockCacheService = MockCacheService();
      mockLoggedUserDataSource = MockLoggedUserDataSource();
      sut = LoggedUserRepository(
        loggedUserDataSource: mockLoggedUserDataSource,
        cacheService: mockCacheService,
      );
    },
  );

  group(
    'Get logged user data',
    () {
      test(
        'Should get Logged user (cache hit)',
        () async {
          when(
            mockCacheService.get<LoggedUser>('loggedUser'),
          ).thenReturn(sampleLoggedUser);
          final result = await sut.getLoggedUser();
          expect(result, isA<LoggedUser>());
          expect(result.email, 'email');
        },
      );
      test(
        'Should get Logged user (cache miss)',
        () async {
          when(
            mockLoggedUserDataSource.getLoggedUser(),
          ).thenAnswer(
            (_) async => sampleLoggedUser,
          );
          when(
            mockCacheService.get<LoggedUser>('loggedUser'),
          ).thenReturn(null);
          final result = await sut.getLoggedUser();
          expect(result, isA<LoggedUser>());
          expect(result.email, 'email');
        },
      );
    },
  );
  group(
    'Update logged user',
    () {
      test(
        'Should update logged user and return the updated user',
        () async {
          when(
            mockCacheService.get<LoggedUser>('loggedUser'),
          ).thenReturn(sampleLoggedUser);
          final result = await sut.updateLoggedUser(
            sampleUpdateLoggedUserDto,
          );
          expect(result.profilePicture, sampleUpdateLoggedUserDto.profilePicture);
        },
      );
    },
  );
}
