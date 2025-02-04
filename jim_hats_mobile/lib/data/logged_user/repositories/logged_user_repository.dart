import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';

class LoggedUserRepository {
  final LoggedUserDataSource _loggedUserDataSource;
  // cache???

  LoggedUserRepository({required LoggedUserDataSource loggedUserDataSource})
      : _loggedUserDataSource = loggedUserDataSource;

  Future<LoggedUser> getLoggedUser() async {
    await Future.delayed(Duration(seconds: 2));
    return await _loggedUserDataSource.getLoggedUser();
  }
}
