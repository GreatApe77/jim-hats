import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/http_exceptions.dart';
import 'package:jim_hats_mobile/core/exceptions/user_not_found_exception.dart';
import 'package:jim_hats_mobile/core/exceptions/username_already_taken_exception.dart';
import 'package:jim_hats_mobile/core/exceptions/wrong_password_exception.dart';
import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/network_auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/dtos/login_dto.dart';
import 'package:jim_hats_mobile/data/auth/dtos/register_dto.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_auth_data_source_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  group(
    'Network Auth data Source tests',
    () {
      late NetworkAuthDataSource sut;
      final LoginDto loginDto = LoginDto(
        username: 'username',
        password: 'password',
      );
      final RegisterDto registerDto = RegisterDto(
        username: 'username',
        email: 'email@email',
        password: 'password',
        profilePicture: 'profilePicture',
      );
      late MockHttpService mockHttpService;
      setUp(
        () {
          mockHttpService = MockHttpService();
          sut = NetworkAuthDataSource(httpClient: mockHttpService);
        },
      );
      group(
        'Login',
        () {
          test(
            'Should login successfuly and return a token',
            () async {
              when(
                mockHttpService.post(
                  '/login',
                  data: loginDto.toMap(),
                ),
              ).thenAnswer(
                (_) async => {
                  'data': {'token': 'some_mocked_token'},
                },
              );

              final token = await sut.login(loginDto);

              expect(token, isA<String>());
            },
          );
          test(
            'Should not login and throw a wrong password exception',
            () {
              when(
                mockHttpService.post(
                  '/login',
                  data: loginDto.toMap(),
                ),
              ).thenAnswer(
                (_) async => throw UnauthorizedException('unauthorized'),
              );
              expect(
                sut.login(loginDto),
                throwsA(
                  isA<WrongPasswordException>(),
                ),
              );
            },
          );
          test(
            'Should not login because user is not found',
            () {
              when(
                mockHttpService.post(
                  '/login',
                  data: loginDto.toMap(),
                ),
              ).thenAnswer(
                (_) async => throw NotFoundException('not found'),
              );
              expect(
                sut.login(loginDto),
                throwsA(
                  isA<UserNotFoundException>(),
                ),
              );
            },
          );
        },
      );
      group(
        'Register',
        () {
          test(
            'Should register',
            () async {
              when(mockHttpService.post('/register', data: registerDto.toMap()))
                  .thenAnswer(
                (realInvocation) async => {'message': 'success'},
              );
              await expectLater(sut.register(registerDto), completes);
            },
          );
          test(
            'Should not register register because the request is a bad request',
            () async {
              when(mockHttpService.post('/register', data: registerDto.toMap()))
                  .thenAnswer(
                (_) => throw BadRequestException('bad request'),
              );

              expectLater(sut.register(registerDto),
                  throwsA(isA<UsernameAlreadyTakenException>()));
            },
          );
          test(
            'Should not register register and rethrow the exception',
            () async {
              when(
                mockHttpService.post(
                  '/register',
                  data: registerDto.toMap(),
                ),
              ).thenAnswer(
                (_) => throw Exception('Random exception'),
              );

              expectLater(
                sut.register(registerDto),
                throwsA(
                  isA<Exception>(),
                ),
              );
            },
          );
        },
      );
    },
  );
}
