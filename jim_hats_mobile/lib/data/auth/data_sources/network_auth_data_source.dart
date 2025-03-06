import 'package:jim_hats_mobile/core/exceptions/http_exceptions.dart';
import 'package:jim_hats_mobile/core/exceptions/user_not_found_exception.dart';
import 'package:jim_hats_mobile/core/exceptions/wrong_password_exception.dart';
import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/dtos/login_dto.dart';
import 'package:jim_hats_mobile/data/auth/dtos/register_dto.dart';
import 'package:jim_hats_mobile/core/exceptions/username_already_taken_exception.dart';

class NetworkAuthDataSource implements AuthDataSource {
  final HttpService httpClient;

  NetworkAuthDataSource({required this.httpClient});

  @override
  Future<String> login(LoginDto loginDto) async {
    try {
      final response = await httpClient.post('/login', data: loginDto.toMap());
      // if (response.statusCode != 200) {
      //   throw Exception('Http error: ${response.statusCode}');
      // }
      //final decoded = jsonDecode(response.data);
      return response['data']['token'] as String;
    } on UnauthorizedException {
      throw WrongPasswordException();
    } on NotFoundException {
      throw UserNotFoundException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(RegisterDto registerDto) async {
    try {
      await httpClient.post('/register', data: registerDto.toMap());
    } on BadRequestException {
      throw UsernameAlreadyTakenException();
    } catch (e) {
      rethrow;
    }
  }
}
