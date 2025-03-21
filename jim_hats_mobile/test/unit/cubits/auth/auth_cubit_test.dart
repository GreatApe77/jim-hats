import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/http_exceptions.dart';
import 'package:jim_hats_mobile/core/exceptions/invalid_token_exception.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/core/exceptions/token_not_found_exception.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/auth/auth_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_cubit_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<LoggedUserRepository>(), MockSpec<AuthRepository>()])
void main() {
  late AuthCubit sut;
  late MockLoggedUserRepository mockLoggedUserRepository;
  late MockAuthRepository mockAuthRepository;
  final sampleLoggedUser = LoggedUser(
    id: 4,
    username: 'username',
    email: 'email',
  );

  setUp(
    () {
      mockAuthRepository = MockAuthRepository();
      mockLoggedUserRepository = MockLoggedUserRepository();
      sut = AuthCubit(
        authRepository: mockAuthRepository,
        loggedUserRepository: mockLoggedUserRepository,
      );
    },
  );

  test(
    'Test initial state is in unknown status and failing:false',
    () {
      expect(sut.state.authStatus, AuthStatus.unknown);
      expect(sut.state.failed, isFalse);
      expect(sut.state.user, isNull);
    },
  );
  blocTest<AuthCubit, AuthState>(
    'Should emit authenticated auth status when auth status is correct',
    setUp: () {
      when(
        mockAuthRepository.isLoggedIn(),
      ).thenAnswer(
        (_) async => true,
      );
      when(mockLoggedUserRepository.getLoggedUser()).thenAnswer(
        (_) async => sampleLoggedUser,
      );
    },
    build: () => sut,
    act: (cubit) => cubit.checkAuthStatus(),
    expect: () => [
      isA<AuthState>().having(
        (state) => state.authStatus,
        'Auth status',
        AuthStatus.unknown,
      ),
      isA<AuthState>()
          .having(
            (state) => state.authStatus,
            'Auth status',
            AuthStatus.authenticated,
          )
          .having(
            (state) => state.user!.email,
            'User email',
            'email',
          ),
    ],
  );
  blocTest<AuthCubit, AuthState>(
    'Check auth status must fail (unknown exception)',
    setUp: () {
      when(
        mockAuthRepository.isLoggedIn(),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockLoggedUserRepository.getLoggedUser(),
      ).thenThrow(
        Error(),
      );
    },
    build: () => sut,
    act: (cubit) => cubit.checkAuthStatus(),
    skip: 1,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.authStatus,
        'Auth status',
        AuthStatus.unauthenticated,
      ),
    ],
  );
  blocTest<AuthCubit, AuthState>(
    'Check auth status must fail (Not logged in)',
    setUp: () {
      when(
        mockAuthRepository.isLoggedIn(),
      ).thenAnswer(
        (_) async => false,
      );
    },
    build: () => sut,
    act: (cubit) => cubit.checkAuthStatus(),
    skip: 1,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.authStatus,
        'Auth status',
        AuthStatus.unauthenticated,
      ),
    ],
  );
  blocTest<AuthCubit, AuthState>(
    'Check auth status must fail (Invalid token exception)',
    setUp: () {
      when(
        mockAuthRepository.isLoggedIn(),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockLoggedUserRepository.getLoggedUser(),
      ).thenThrow(
        InvalidTokenException(),
      );
    },
    build: () => sut,
    act: (cubit) => cubit.checkAuthStatus(),
    skip: 1,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.authStatus,
        'Auth status',
        AuthStatus.unauthenticated,
      ),
    ],
  );
  blocTest<AuthCubit, AuthState>(
    'Check auth status must fail (Token Not found exception)',
    setUp: () {
      when(
        mockAuthRepository.isLoggedIn(),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockLoggedUserRepository.getLoggedUser(),
      ).thenThrow(
        TokenNotFoundException(),
      );
    },
    build: () => sut,
    act: (cubit) => cubit.checkAuthStatus(),
    skip: 1,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.authStatus,
        'Auth status',
        AuthStatus.unauthenticated,
      ),
    ],
  );
  blocTest<AuthCubit, AuthState>(
    'Check auth status must fail (Server Exception)',
    setUp: () {
      when(
        mockAuthRepository.isLoggedIn(),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockLoggedUserRepository.getLoggedUser(),
      ).thenThrow(
        ServerException('ERROR FROM SERVER'),
      );
    },
    build: () => sut,
    act: (cubit) => cubit.checkAuthStatus(),
    skip: 1,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.failed,
        'Failing status',
        isTrue,
      ),
    ],
  );
  blocTest<AuthCubit, AuthState>(
    'Check auth status must fail (Server timeout)',
    setUp: () {
      when(
        mockAuthRepository.isLoggedIn(),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockLoggedUserRepository.getLoggedUser(),
      ).thenThrow(
        TimeOutException(),
      );
    },
    build: () => sut,
    act: (cubit) => cubit.checkAuthStatus(),
    skip: 1,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.failed,
        'Failing status',
        isTrue,
      ),
    ],
  );
  blocTest<AuthCubit, AuthState>(
    'Log out should update the states',
    build: () => sut,
    act: (cubit) => cubit.logOut(),
    verify: (_) {
      verify(mockAuthRepository.logout()).called(1);
    },
    expect: () => [
      isA<AuthState>()
          .having(
            (state) => state.user,
            'User',
            isNull,
          )
          .having(
            (state) => state.authStatus,
            'Auth status',
            AuthStatus.unauthenticated,
          ),
    ],
  );
}
