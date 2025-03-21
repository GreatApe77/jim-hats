import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_account_page/create_account_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_account_page_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>(), MockSpec<UploadRepository>()])
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUploadRepository mockUploadRepository;
  late CreateAccountPageCubit sut;
  final sampleApplicationException = TimeOutException();
  setUp(
    () {
      mockUploadRepository = MockUploadRepository();
      mockAuthRepository = MockAuthRepository();
      sut = CreateAccountPageCubit(
        authRepository: mockAuthRepository,
        uploadRepository: mockUploadRepository,
      );
    },
  );

  test(
    'Should start with empty initial state',
    () {
      expect(sut.state.username, '');
      expect(sut.state.password, '');
      expect(sut.state.confirmPassword, '');
      expect(sut.state.errorMessage, '');
      expect(sut.state.status, Status.writingForm);
      expect(sut.state.image, isNull);
    },
  );

  blocTest<CreateAccountPageCubit, CreateAccountPageState>(
    'Should add image',
    build: () => sut,
    act: (cubit) => cubit.addImage(XFile('')),
    expect: () => [
      isA<CreateAccountPageState>().having(
        (state) => state.image,
        'Image',
        isA<XFile>(),
      )
    ],
  );
  blocTest<CreateAccountPageCubit, CreateAccountPageState>(
    'Should clear image',
    build: () => sut,
    act: (cubit) => cubit.clearImage(),
    expect: () => [
      isA<CreateAccountPageState>().having(
        (state) => state.image,
        'Image',
        isNull,
      ),
    ],
  );
  blocTest<CreateAccountPageCubit, CreateAccountPageState>(
    'Should update username',
    build: () => sut,
    act: (cubit) => cubit.updateUsername('testUsername'),
    expect: () => [
      isA<CreateAccountPageState>().having(
        (state) => state.username,
        'Username',
        'testUsername',
      ),
    ],
  );
  blocTest<CreateAccountPageCubit, CreateAccountPageState>(
    'Should update email',
    build: () => sut,
    act: (cubit) => cubit.updateEmail('testEmail'),
    expect: () => [
      isA<CreateAccountPageState>().having(
        (state) => state.email,
        'Email',
        'testEmail',
      ),
    ],
  );
  blocTest<CreateAccountPageCubit, CreateAccountPageState>(
    'Should update password',
    build: () => sut,
    act: (cubit) => cubit.updatePassword('testPassword'),
    expect: () => [
      isA<CreateAccountPageState>().having(
        (state) => state.password,
        'Password',
        'testPassword',
      ),
    ],
  );
  blocTest<CreateAccountPageCubit, CreateAccountPageState>(
    'Should update confirm password',
    build: () => sut,
    act: (cubit) => cubit.updateConfirmPassword('testPassword'),
    expect: () => [
      isA<CreateAccountPageState>().having(
        (state) => state.confirmPassword,
        'Confirm Password',
        'testPassword',
      ),
    ],
  );

  group(
    'Form submission',
    () {
      blocTest<CreateAccountPageCubit, CreateAccountPageState>(
        'Should not submit form because passwords dont match',
        build: () => sut,
        act: (cubit) {
          cubit.updatePassword('ultrasecret123');
          cubit.updateConfirmPassword('notsecret1234');
          cubit.submitForm();
        },
        skip: 2,
        expect: () => [
          isA<CreateAccountPageState>()
              .having(
                (state) => state.status,
                'Status',
                Status.error,
              )
              .having(
                (state) => state.errorMessage,
                'Error message',
                'Passwords do not match',
              ),
          isA<CreateAccountPageState>()
              .having(
                (state) => state.status,
                'Status',
                Status.writingForm,
              )
              .having(
                (state) => state.errorMessage,
                'Error message',
                '',
              ),
        ],
      );
      blocTest<CreateAccountPageCubit, CreateAccountPageState>(
        'Should submit the form without uploading image',
        build: () => sut,
        act: (cubit) {
          cubit.submitForm();
        },
        verify: (bloc) {
          verify(mockAuthRepository.register(any)).called(1);
          verifyZeroInteractions(mockUploadRepository);
        },
        expect: () => [
          isA<CreateAccountPageState>().having(
            (state) => state.status,
            'Status',
            Status.loading,
          ),
          isA<CreateAccountPageState>().having(
            (state) => state.status,
            'Status',
            Status.success,
          ),
        ],
      );
      blocTest<CreateAccountPageCubit, CreateAccountPageState>(
        'Should submit the form uploading image',
        build: () => sut,
        act: (cubit) {
          cubit.addImage(XFile(''));
          cubit.submitForm();
        },
        verify: (bloc) {
          verify(mockAuthRepository.register(any)).called(1);
          verify(mockUploadRepository.uploadFile(any)).called(1);
        },
        skip: 1,
        expect: () => [
          isA<CreateAccountPageState>().having(
            (state) => state.status,
            'Status',
            Status.loading,
          ),
          isA<CreateAccountPageState>().having(
            (state) => state.status,
            'Status',
            Status.success,
          ),
        ],
      );
      blocTest<CreateAccountPageCubit, CreateAccountPageState>(
        'Should emit error state when the form submission fails (Application Exception)',
        setUp: () {
          when(
            mockAuthRepository.register(
              any,
            ),
          ).thenThrow(
            sampleApplicationException,
          );
        },
        build: () => sut,
        act: (cubit) {
          cubit.submitForm();
        },
        verify: (bloc) {
          verify(mockAuthRepository.register(any)).called(1);
          verifyZeroInteractions(mockUploadRepository);
        },
        expect: () => [
          isA<CreateAccountPageState>().having(
            (state) => state.status,
            'Status',
            Status.loading,
          ),
          isA<CreateAccountPageState>()
              .having(
                (state) => state.status,
                'Status',
                Status.error,
              )
              .having(
                (state) => state.errorMessage,
                'Error message',
                sampleApplicationException.getMessage(),
              ),
        ],
      );
    },
  );
}
