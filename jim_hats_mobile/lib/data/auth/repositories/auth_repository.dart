import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/network_auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/dtos/login_dto.dart';
import 'package:jim_hats_mobile/data/auth/dtos/register_dto.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:jim_hats_mobile/shared/http/http_client.dart';
import 'package:jim_hats_mobile/shared/utils/memory_cache.dart';

class AuthRepository {
  final AuthDataSource _authDataSource;
  final SettingsDataSource _settingsDataSource;
  AuthRepository({
    required SettingsDataSource settingsDatasource,
    required AuthDataSource authDataSource,
  })  : _authDataSource = authDataSource,
        _settingsDataSource = settingsDatasource;

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
      await _settingsDataSource.set<String>('token',token);
      return token;
    } catch (e) {
      rethrow;
    }
  }
  Future<void> logout() async {
      MemoryCache.clearCache();
      await _settingsDataSource.remove('token');
  }
  Future<bool> isLoggedIn() async {
    final token = await _settingsDataSource.get<String>('token');
    return token!=null;    
  }
}
