import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/shared/utils/memory_cache.dart';

class LoggedUserRepository {
  final LoggedUserDataSource _loggedUserDataSource;

  // cache???

  LoggedUserRepository({
    required LoggedUserDataSource? loggedUserDataSource,
  }) : _loggedUserDataSource =
            loggedUserDataSource ?? locator.get<LoggedUserDataSource>();

  Future<LoggedUser> getLoggedUser() async {
    try {
      var loggedUser = MemoryCache.get<LoggedUser>('loggedUser');
      if (loggedUser == null) {
        //await Future.delayed(Duration(seconds: 2));
        loggedUser = await _loggedUserDataSource.getLoggedUser();
        MemoryCache.store('loggedUser', loggedUser,
            duration: Duration(minutes: 1));
      }
      return loggedUser;
    } on TimeOutException {
      rethrow;
    }
  }
}
