import 'package:jim_hats_mobile/data/auth/dtos/login_dto.dart';
import 'package:jim_hats_mobile/data/auth/dtos/register_dto.dart';

abstract class AuthDataSource {
  Future<void> register(RegisterDto registerDto);

  Future<String> login(LoginDto loginDto);
}
