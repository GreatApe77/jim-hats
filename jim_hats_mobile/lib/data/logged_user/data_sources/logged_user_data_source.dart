import 'package:jim_hats_mobile/data/logged_user/dtos/update_logged_user_dto.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';

abstract class LoggedUserDataSource {
  Future<LoggedUser> getLoggedUser();
  Future<void> updateLoggedUser(UpdateLoggedUserDto updateLoggedUserDto);
}