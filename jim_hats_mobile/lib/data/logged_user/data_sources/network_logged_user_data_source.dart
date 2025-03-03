import 'dart:async';

import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/core/exceptions/http_exceptions.dart';
import 'package:jim_hats_mobile/core/exceptions/invalid_token_exception.dart';
import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/dtos/update_logged_user_dto.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/core/network/http_client.dart';

class NetworkLoggedUserDataSource implements LoggedUserDataSource {
  final HttpService _httpClient;
  NetworkLoggedUserDataSource({
    required HttpService httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<LoggedUser> getLoggedUser() async {
    //_httpClient.dio.get('', options: Options());
    try {
      final response = await _httpClient.get(
        '/users/me',
      );
      return LoggedUser.fromMap(response['data']);
    } on UnauthorizedException {
      throw InvalidTokenException();
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
  Future<void> updateLoggedUser(UpdateLoggedUserDto updateLoggedUserDto) async {
    //_httpClient.dio.get('', options: Options());
    try {
      _httpClient.patch(
        '/users/me',
        data: updateLoggedUserDto.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
