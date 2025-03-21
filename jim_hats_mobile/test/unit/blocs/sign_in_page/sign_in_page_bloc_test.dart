import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/data/auth/dtos/login_dto.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';
import 'package:jim_hats_mobile/presentation/blocs/sign_in_page/sign_in_page_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_in_page_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInPageBloc sut;
  final sampleTimeoutException = TimeOutException();

  setUp(
    () {
      mockAuthRepository = MockAuthRepository();
      sut = SignInPageBloc(
        authRepository: mockAuthRepository,
      );
    },
  );
  test(
    'Should have empty initial state',
    () {
      expect(sut.state, isA<SignInPageState>());
      expect(sut.state.message, '');
      expect(sut.state.password, '');
      expect(sut.state.status, SignInPageStatus.writingForm);
      expect(sut.state.username, '');
    },
  );
  blocTest<SignInPageBloc, SignInPageState>(
    'Should update username state',
    build: () => sut,
    act: (bloc) => bloc.add(SignInUsernameChanged(username: 'CHANGED')),
    expect: () => [
      isA<SignInPageState>()
          .having((state) => state.username, 'username', 'CHANGED')
    ],
  );
  blocTest<SignInPageBloc, SignInPageState>(
    'Should update password state',
    build: () => sut,
    act: (bloc) => bloc.add(SignInPasswordChanged(password: 'secret')),
    expect: () => [
      isA<SignInPageState>().having(
        (state) => state.password,
        'password',
        'secret',
      )
    ],
  );
  group(
    'Submit form',
    () {
      blocTest<SignInPageBloc, SignInPageState>(
        'Should successfully submit the form and update its state',
        build: () => sut,
        act: (bloc) => bloc.add(SignInFormSubmitted()),
        expect: () => [
          isA<SignInPageState>().having(
            (state) => state.status,
            'status',
            SignInPageStatus.loading,
          ),
          isA<SignInPageState>().having(
            (state) => state.status,
            'status',
            SignInPageStatus.success,
          ),
        ],
      );
      blocTest<SignInPageBloc, SignInPageState>(
        'Should submit the form but throws a expected Application error',
        setUp: () {
          when(mockAuthRepository.login(any)).thenThrow(
            sampleTimeoutException
          );
        },
        build: () => sut,
        act: (bloc) => bloc.add(SignInFormSubmitted()),
        expect: () => [
          isA<SignInPageState>().having(
            (state) => state.status,
            'status',
            SignInPageStatus.loading,
          ),
          isA<SignInPageState>()
              .having(
                (state) => state.status,
                'status',
                SignInPageStatus.failure,
              )
              .having(
                (state) => state.message,
                'error message',
                sampleTimeoutException.getMessage(),
              ),
        ],
      );
       blocTest<SignInPageBloc, SignInPageState>(
        'Should submit the form but throws an unknown error',
        setUp: () {
          when(mockAuthRepository.login(any)).thenThrow(
            Exception()
          );
        },
        build: () => sut,
        act: (bloc) => bloc.add(SignInFormSubmitted()),
        expect: () => [
          isA<SignInPageState>().having(
            (state) => state.status,
            'status',
            SignInPageStatus.loading,
          ),
          isA<SignInPageState>()
              .having(
                (state) => state.status,
                'status',
                SignInPageStatus.failure,
              )
              .having(
                (state) => state.message,
                'error message',
                'Unknown error while signing in'
              ),
        ],
      );
    },
  );
}
