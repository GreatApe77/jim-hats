import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_challenge_page/create_challenge_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'create_challenge_cubit_page_test.mocks.dart';

// final UploadRepository _uploadRepository;
//   final GymChallengesRepository _gymChallengesRepository;
@GenerateNiceMocks([
  MockSpec<UploadRepository>(),
  MockSpec<GymChallengesRepository>(),
])
void main() {
  late CreateChallengePageCubit sut;
  late MockUploadRepository mockUploadRepository;
  late MockGymChallengesRepository mockGymChallengesRepository;

  setUp(
    () {
      mockGymChallengesRepository = MockGymChallengesRepository();
      mockUploadRepository = MockUploadRepository();
      sut = CreateChallengePageCubit(
        uploadRepository: mockUploadRepository,
        gymChallengesRepository: mockGymChallengesRepository,
      );
    },
  );
  test('Should get day difference between 2 dates', () {
    final startAt = DateTime(2025, 10, 1);
    final endAt = DateTime(2025, 10, 31);
    final difference = sut.getDayCount(startAt, endAt);
    expect(difference, 30);
  });

  test(
    'Should start with initial state',
    () {
      expect(sut.state.description, '');
      expect(sut.state.name, '');
      expect(sut.state.errorMessage, '');
      expect(sut.state.status, CreateChallengePageStatus.idle);
    },
  );

  blocTest<CreateChallengePageCubit, CreateChallengePageState>(
    'Should update challenge name state',
    build: () => sut,
    act: (cubit) => cubit.updateName('Challenge1'),
    expect: () => [
      isA<CreateChallengePageState>().having(
        (state) => state.name,
        'Name',
        'Challenge1',
      )
    ],
  );
  blocTest<CreateChallengePageCubit, CreateChallengePageState>(
    'Should update challenge description state',
    build: () => sut,
    act: (cubit) => cubit.updateDescription('Description'),
    expect: () => [
      isA<CreateChallengePageState>().having(
        (state) => state.description,
        'Description',
        'Description',
      )
    ],
  );
  blocTest<CreateChallengePageCubit, CreateChallengePageState>(
    'Should update challenge image state for a not null value',
    build: () => sut,
    act: (cubit) => cubit.updateImage(XFile('')),
    expect: () => [
      isA<CreateChallengePageState>().having(
        (state) => state.image,
        'Image',
        isA<XFile>(),
      )
    ],
  );
  blocTest<CreateChallengePageCubit, CreateChallengePageState>(
    'Should update challenge image state for a  null value',
    build: () => sut,
    act: (cubit) => cubit.updateImage(null),
    expect: () => [
      isA<CreateChallengePageState>().having(
        (state) => state.image,
        'Image',
        isNull,
      )
    ],
  );
  blocTest<CreateChallengePageCubit, CreateChallengePageState>(
    'Should update startAt date',
    build: () => sut,
    act: (cubit) => cubit.updateStartAt(
      DateTime(2025),
    ),
    expect: () => [
      isA<CreateChallengePageState>().having(
        (state) => state.startAt.year,
        'Start at date',
        2025,
      )
    ],
  );
  blocTest<CreateChallengePageCubit, CreateChallengePageState>(
    'Should update endAt date',
    build: () => sut,
    act: (cubit) => cubit.updateEndAt(
      DateTime(2026),
    ),
    expect: () => [
      isA<CreateChallengePageState>().having(
        (state) => state.endAt.year,
        'End at date',
        2026,
      )
    ],
  );

  group(
    'Form submission',
    () {
      blocTest<CreateChallengePageCubit, CreateChallengePageState>(
        'Should submit the form without the image',
        build: () => sut,
        act: (cubit) => cubit.submitForm(),
        verify: (cubit) {
          verifyZeroInteractions(mockUploadRepository);
          verify(
            mockGymChallengesRepository.createGymChallenge(any),
          ).called(1);
        },
        expect: () => [
          isA<CreateChallengePageState>().having(
            (state) => state.status,
            'Status',
            CreateChallengePageStatus.loading,
          ),
          isA<CreateChallengePageState>().having(
            (state) => state.status,
            'Status',
            CreateChallengePageStatus.success,
          ),
        ],
      );
      blocTest<CreateChallengePageCubit, CreateChallengePageState>(
        'Should submit the form with an image',
        build: () => sut,
        act: (cubit) {
          cubit.updateImage(XFile(''));
          cubit.submitForm();
        },
        skip: 1,
        verify: (cubit) {
          verify(
            mockUploadRepository.uploadFile(any),
          ).called(1);
          verify(
            mockGymChallengesRepository.createGymChallenge(any),
          ).called(1);
        },
        expect: () => [
          isA<CreateChallengePageState>().having(
            (state) => state.status,
            'Status',
            CreateChallengePageStatus.loading,
          ),
          isA<CreateChallengePageState>().having(
            (state) => state.status,
            'Status',
            CreateChallengePageStatus.success,
          ),
        ],
      );
      blocTest<CreateChallengePageCubit, CreateChallengePageState>(
        'Should handle an exception while submiting form',
        build: () => sut,
        setUp: () {
          when(
            mockGymChallengesRepository.createGymChallenge(any),
          ).thenThrow(
            Error(),
          );
        },
        act: (cubit) {
          cubit.submitForm();
        },
        expect: () => [
          isA<CreateChallengePageState>().having(
            (state) => state.status,
            'Status',
            CreateChallengePageStatus.loading,
          ),
          isA<CreateChallengePageState>().having(
            (state) => state.status,
            'Status',
            CreateChallengePageStatus.error,
          ),
        ],
      );
    },
  );
}
