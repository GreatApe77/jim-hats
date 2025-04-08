import 'package:jim_hats_mobile/core/utils/cache_service.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/dtos/update_logged_user_dto.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';

class LoggedUserRepository {
  final LoggedUserDataSource _loggedUserDataSource;
  final CacheService _cacheService;
  // cache???

  LoggedUserRepository({
    required LoggedUserDataSource loggedUserDataSource,
    required CacheService cacheService,
  })  : _cacheService = cacheService,
        _loggedUserDataSource = loggedUserDataSource;

  Future<LoggedUser> getLoggedUser() async {
    var loggedUser = _cacheService.get<LoggedUser>('loggedUser');
    if (loggedUser == null) {
      //await Future.delayed(Duration(seconds: 2));
      loggedUser = await _loggedUserDataSource.getLoggedUser();
      _cacheService.store(
        'loggedUser',
        loggedUser,
        duration: Duration(
          minutes: 1,
        ),
      );
    }
    return loggedUser;
  }

  Future<LoggedUser> updateLoggedUser(
    UpdateLoggedUserDto updateLoggedUserDto,
  ) async {
    await _loggedUserDataSource.updateLoggedUser(updateLoggedUserDto);
    final loggedUser = await getLoggedUser();
    return loggedUser.copyWith(
      profilePicture: updateLoggedUserDto.profilePicture,
    );
  }
}
