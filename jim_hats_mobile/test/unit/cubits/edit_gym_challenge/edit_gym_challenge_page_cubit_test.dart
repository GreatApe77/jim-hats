import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/edit_gym_challenge_page/edit_gym_challenge_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_gym_challenge_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UploadRepository>(),
  MockSpec<GymChallengesRepository>(),
])
void main() {
  late EditGymChallengePageCubit sut;
  late MockUploadRepository mockUploadRepository;
  late MockGymChallengesRepository mockGymChallengesRepository;
  final sampleChallengeId = 9;
  final sampleApplicationException = TimeOutException();

  setUp(
    () {
      mockGymChallengesRepository = MockGymChallengesRepository();
      mockUploadRepository = MockUploadRepository();
      sut = EditGymChallengePageCubit(
        uploadRepository: mockUploadRepository,
        gymChallengesRepository: mockGymChallengesRepository,
      );
    },
  );
  test(
    'Should have empty initial state',
    () {
      expect(sut.state.name, '');
      expect(sut.state.description, '');
      expect(sut.state.errorMessage, '');
      expect(sut.state.imageUrl, '');
      expect(sut.state.status, EditGymChallengePageStatus.idle);
      expect(sut.state.image, isNull);
      expect(sut.state.startAt, isA<DateTime>());
      expect(sut.state.endAt, isA<DateTime>());
    },
  );

  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should update the challenge name',
    build: () => sut,
    act: (cubit) => cubit.updateName('challenge1'),
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.name,
        'Name',
        'challenge1',
      )
    ],
  );
  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should update the challenge description',
    build: () => sut,
    act: (cubit) => cubit.updateDescription('descriptionChanged'),
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.description,
        'Description',
        'descriptionChanged',
      )
    ],
  );
  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should update the image url',
    build: () => sut,
    act: (cubit) => cubit.updateImageUrl('url.com'),
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.imageUrl,
        'Image url',
        'url.com',
      )
    ],
  );
  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should update startAt date',
    build: () => sut,
    act: (cubit) => cubit.updateStartAt(
      DateTime(2024),
    ),
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.startAt.year,
        'Start at date',
        2024,
      )
    ],
  );
  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should update endAt date',
    build: () => sut,
    act: (cubit) => cubit.updateEndAt(
      DateTime(2024),
    ),
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.endAt.year,
        'Enda at date',
        2024,
      )
    ],
  );
  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should update image file',
    build: () => sut,
    act: (cubit) => cubit.updateImageFile(XFile('')),
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.image,
        'Image file',
        isA<XFile>(),
      )
    ],
  );
  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should submit the form without updating the image',
    build: () => sut,
    act: (cubit) {
      cubit.updateStartAt(DateTime(2025));
      cubit.updateEndAt(DateTime(2026));
      cubit.submitForm(sampleChallengeId);
    },
    skip: 2,
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.status,
        'Status',
        EditGymChallengePageStatus.loading,
      ),
      isA<EditGymChallengePageState>().having(
        (state) => state.status,
        'Status',
        EditGymChallengePageStatus.success,
      )
    ],
  );
  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should submit the form while updating the image',
    build: () => sut,
    act: (cubit) {
      cubit.updateStartAt(DateTime(2025));
      cubit.updateEndAt(DateTime(2026));
      cubit.updateImageFile(XFile(''));
      cubit.submitForm(sampleChallengeId);
    },
    verify: (cubit) {
      verify(mockUploadRepository.uploadFile(any)).called(1);
    },
    skip: 3,
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.status,
        'Status',
        EditGymChallengePageStatus.loading,
      ),
      isA<EditGymChallengePageState>().having(
        (state) => state.status,
        'Status',
        EditGymChallengePageStatus.success,
      )
    ],
  );
  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should not submit the form because startAt is after endAt',
    build: () => sut,
    act: (cubit) {
      cubit.updateStartAt(DateTime(2026));
      cubit.updateEndAt(DateTime(2025));

      cubit.submitForm(sampleChallengeId);
    },
    skip: 2,
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.status,
        'Status',
        EditGymChallengePageStatus.loading,
      ),
      isA<EditGymChallengePageState>()
          .having(
            (state) => state.status,
            'Status',
            EditGymChallengePageStatus.error,
          )
          .having(
            (state) => state.errorMessage,
            'Status',
            'End date must be after start date',
          )
    ],
  );
  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should handle expected Application Exception while submiting the form',
    build: () => sut,
    setUp: () {
      when(mockGymChallengesRepository.updateGymChallenge(any, any))
          .thenThrow(sampleApplicationException);
    },
    act: (cubit) {
      cubit.updateStartAt(DateTime(2025));
      cubit.updateEndAt(DateTime(2026));
      cubit.submitForm(sampleChallengeId);
    },
    skip: 2,
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.status,
        'Status',
        EditGymChallengePageStatus.loading,
      ),
      isA<EditGymChallengePageState>()
          .having(
            (state) => state.status,
            'Status',
            EditGymChallengePageStatus.error,
          )
          .having(
            (state) => state.errorMessage,
            'Status',
            sampleApplicationException.getMessage(),
          )
    ],
  );
  blocTest<EditGymChallengePageCubit, EditGymChallengePageState>(
    'Should handle unknown error while submiting the form',
    build: () => sut,
    setUp: () {
      when(mockGymChallengesRepository.updateGymChallenge(any, any))
          .thenThrow(Error());
    },
    act: (cubit) {
      cubit.updateStartAt(DateTime(2025));
      cubit.updateEndAt(DateTime(2026));
      cubit.submitForm(sampleChallengeId);
    },
    skip: 2,
    expect: () => [
      isA<EditGymChallengePageState>().having(
        (state) => state.status,
        'Status',
        EditGymChallengePageStatus.loading,
      ),
      isA<EditGymChallengePageState>()
          .having(
            (state) => state.status,
            'Status',
            EditGymChallengePageStatus.error,
          )
          .having(
            (state) => state.errorMessage,
            'Status',
            'Unknown error while updating challenge',
          )
    ],
  );
}
