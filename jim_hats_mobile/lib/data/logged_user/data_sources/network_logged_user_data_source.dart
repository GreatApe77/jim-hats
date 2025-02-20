import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:jim_hats_mobile/shared/http/http_client.dart';

class NetworkLoggedUserDataSource implements LoggedUserDataSource {
  final SettingsDataSource _settingsDataSource;
  final HttpClient _httpClient;
  NetworkLoggedUserDataSource(
      {required HttpClient httpClient,
      required SettingsDataSource settingsDataSource})
      : _httpClient = httpClient,
        _settingsDataSource = settingsDataSource;
  @override
  Future<LoggedUser> getLoggedUser() async {
    //_httpClient.dio.get('', options: Options());
    try {
      final jwtToken = await _settingsDataSource.get<String>('token');
      final response = await _httpClient.dio.get<Map<String, dynamic>>(
          '/users/me',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      return LoggedUser.fromMap(response.data?['data']['user']);
    } catch (e) {
      rethrow;
    }
    // return Future.value(LoggedUser.fromMap({
    //   'username': 'Mateus',
    //   'id': 4,
    //   'email': 'mateus@gmail.com',
    //   'profilePicture':
    //       'https://avatars.githubusercontent.com/u/67892495?s=200&v=4'
    // }));
  }
}
