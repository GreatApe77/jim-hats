// coverage:ignore-file
import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/dtos/update_logged_user_dto.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';

class MemoryLoggedUserDataSource implements LoggedUserDataSource {
  @override
  Future<LoggedUser> getLoggedUser() {
    return Future.value(LoggedUser.fromMap({
      'username': 'Mateus',
      'id': 4,
      'email': 'mateus@gmail.com',
      'profilePicture':
          'https://avatars.githubusercontent.com/u/67892495?s=200&v=4'
    }));
  }

  @override
  Future<void> updateLoggedUser(UpdateLoggedUserDto updateLoggedUserDto) {
    // TODO: implement updateLoggedUser
    throw UnimplementedError();
  }
}
