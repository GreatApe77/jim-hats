import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';

abstract class LoggedUserDataSource {
  Future<LoggedUser> getLoggedUser();
}