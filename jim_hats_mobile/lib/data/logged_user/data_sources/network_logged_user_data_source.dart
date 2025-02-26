import 'dart:async';

import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/dtos/update_logged_user_dto.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:jim_hats_mobile/exceptions/time_out_exception.dart';
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
      return LoggedUser.fromMap(response.data?['data']);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeOutException();
      }
      rethrow;
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
  @override
  Future<void> updateLoggedUser(UpdateLoggedUserDto updateLoggedUserDto) async{
    //_httpClient.dio.get('', options: Options());
    try {
      final jwtToken = await _settingsDataSource.get<String>('token');
      _httpClient.dio.patch<Map<String, dynamic>>(
          '/users/me',
          data: updateLoggedUserDto.toMap(),
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
     
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeOutException();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  } 
}
