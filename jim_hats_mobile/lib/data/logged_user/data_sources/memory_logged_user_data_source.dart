import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';

class MemoryLoggedUserDataSource implements LoggedUserDataSource {
  @override
  Future<LoggedUser> getLoggedUser() {
    return Future.value(LoggedUser.fromMap({
      'username': 'Mateus',
      'id': 4,
      'email': 'mateus@gmail.com',
      'profilePicture': null
    }));
  }
}
