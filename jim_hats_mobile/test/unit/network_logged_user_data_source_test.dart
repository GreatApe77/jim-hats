import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/http_exceptions.dart';
import 'package:jim_hats_mobile/core/exceptions/invalid_token_exception.dart';
import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/network_logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/dtos/update_logged_user_dto.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_logged_user_data_source_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  late NetworkLoggedUserDataSource sut;
  late HttpService mockHttpClient;
  final UpdateLoggedUserDto sampleUpdateDto =
      UpdateLoggedUserDto(profilePicture: 'https://profile.com/1.jpg');
  setUp(
    () {
      mockHttpClient = MockHttpService();
      sut = NetworkLoggedUserDataSource(httpClient: mockHttpClient);
    },
  );

  group(
    'Get logged user',
    () {
      test(
        'Should return an instance of LoggedUser',
        () async {
          when(mockHttpClient.get('/users/me')).thenAnswer(
            (realInvocation) async => {
              'data': {
                'username': 'Mateus',
                'id': 4,
                'email': 'mateus@gmail.com',
                'profilePicture': 'https://profilepic.com'
              }
            },
          );
          final result = await sut.getLoggedUser();
          expect(result.id, 4);
          expect(result.username, 'Mateus');
          expect(result, isA<LoggedUser>());
        },
      );
      test('Should not get logged user because token is invalid', () async {
        when(mockHttpClient.get('/users/me')).thenAnswer(
          (realInvocation) async =>
              throw UnauthorizedException('invalid token'),
        );
        await expectLater(
          sut.getLoggedUser(),
          throwsA(
            isA<InvalidTokenException>(),
          ),
        );
      });
      test('Should not get logged user unknown exception', () async {
        when(mockHttpClient.get('/users/me')).thenAnswer(
          (realInvocation) async => throw Exception('unknown'),
        );
        await expectLater(
          sut.getLoggedUser(),
          throwsA(
            isA<Exception>(),
          ),
        );
      });
    },
  );
  group('Update User', () {
    test(
      'Should update the user information',
      () async {
        when(mockHttpClient.patch('/users/me', data: sampleUpdateDto.toMap()))
            .thenAnswer(
          (realInvocation) async => {'message': 'success'},
        );
        await expectLater(sut.updateLoggedUser(sampleUpdateDto), completes);
      },
    );
  });
}
