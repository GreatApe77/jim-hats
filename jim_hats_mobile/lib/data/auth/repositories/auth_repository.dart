import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/network_auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/dtos/login_dto.dart';
import 'package:jim_hats_mobile/data/auth/dtos/register_dto.dart';
import 'package:jim_hats_mobile/shared/http/http_client.dart';

class AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepository({required AuthDataSource authDataSource}):_authDataSource=authDataSource;

  Future<void> register(RegisterDto registerDto) async {
    try {
      await _authDataSource.register(registerDto);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> login(LoginDto loginDto) async {
    try {
      final String token = await _authDataSource.login(loginDto);
      return token;
    } catch (e) {
      rethrow;
    }
  }
}