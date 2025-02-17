import 'dart:convert';

import 'package:jim_hats_mobile/data/auth/data_sources/auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/dtos/login_dto.dart';
import 'package:jim_hats_mobile/data/auth/dtos/register_dto.dart';
import 'package:jim_hats_mobile/shared/http/http_client.dart';

class NetworkAuthDataSource implements AuthDataSource {
  final HttpClient httpClient;

  NetworkAuthDataSource({required this.httpClient});

  @override
  Future<String> login(LoginDto loginDto) async {
    try {
      final response =
          await httpClient.dio.post('/login', data: loginDto.toMap());
      if (response.statusCode != 200) {
        throw Exception('Http error: ${response.statusCode}');
      }
      //final decoded = jsonDecode(response.data);
      return response.data['data']['token'] as String;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(RegisterDto registerDto) async {
    try {
      final response =
          await httpClient.dio.post('/register', data: registerDto.toMap());
      if (response.statusCode != 201) {
        throw Exception('Http error: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
