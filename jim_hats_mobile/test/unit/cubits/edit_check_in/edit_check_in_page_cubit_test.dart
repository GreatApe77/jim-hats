import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/edit_check_in_page/edit_check_in_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_check_in_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UploadRepository>(),
  MockSpec<ExerciseLogsRepository>(),
])
void main() {
  late EditCheckInPageCubit sut;
  late MockUploadRepository mockUploadRepository;
  late MockExerciseLogsRepository mockExerciseLogsRepository;
  final sampleChallengeId = 1;
  final sampleExerciseLogId = 2;
  final sampleApplicationException = TimeOutException();
  setUp(
    () {
      mockExerciseLogsRepository = MockExerciseLogsRepository();
      mockUploadRepository = MockUploadRepository();
      sut = EditCheckInPageCubit(
        uploadRepository: mockUploadRepository,
        exerciseLogsRepository: mockExerciseLogsRepository,
      );
    },
  );

  test(
    'Should start with empty initial state',
    () {
      expect(sut.state.title, '');
      expect(sut.state.description, '');
      expect(sut.state.errorMessage, '');
      expect(sut.state.image, isNull);
      expect(sut.state.imageUrl, '');
      expect(sut.state.status, EditCheckInPageStatus.idle);
    },
  );
  blocTest<EditCheckInPageCubit, EditCheckInPageState>(
    'Should update title',
    build: () => sut,
    act: (cubit) => cubit.updateTitle('title'),
    expect: () => [
      isA<EditCheckInPageState>().having(
        (state) => state.title,
        'Title',
        'title',
      ),
    ],
  );
  blocTest<EditCheckInPageCubit, EditCheckInPageState>(
    'Should update description',
    build: () => sut,
    act: (cubit) => cubit.updateDescription('newDescription'),
    expect: () => [
      isA<EditCheckInPageState>().having(
        (state) => state.description,
        'Description',
        'newDescription',
      ),
    ],
  );
  blocTest<EditCheckInPageCubit, EditCheckInPageState>(
    'Should update image url',
    build: () => sut,
    act: (cubit) => cubit.updateImageUrl('https://url.com/'),
    expect: () => [
      isA<EditCheckInPageState>().having(
        (state) => state.imageUrl,
        'Image url',
        'https://url.com/',
      ),
    ],
  );
  blocTest<EditCheckInPageCubit, EditCheckInPageState>(
    'Should update image file',
    build: () => sut,
    act: (cubit) => cubit.updateImageFile(XFile('')),
    expect: () => [
      isA<EditCheckInPageState>().having(
        (state) => state.image,
        'Image file',
        isA<XFile>(),
      ),
    ],
  );
  blocTest<EditCheckInPageCubit, EditCheckInPageState>(
    'Should submit form without updating a new image',
    build: () => sut,
    act: (cubit) => cubit.submitForm(
      challengeId: sampleChallengeId,
      exerciseLogId: sampleExerciseLogId,
    ),
    verify: (cubit) {
      verifyZeroInteractions(mockUploadRepository);
      verify(
        mockExerciseLogsRepository.updateExerciseLog(
          challengeId: anyNamed('challengeId'),
          exerciseLogId: anyNamed('exerciseLogId'),
          updateExerciseLogDto: anyNamed('updateExerciseLogDto'),
        ),
      ).called(1);
    },
    expect: () => [
      isA<EditCheckInPageState>().having(
        (state) => state.status,
        'Status',
        EditCheckInPageStatus.loading,
      ),
      isA<EditCheckInPageState>().having(
        (state) => state.status,
        'Status',
        EditCheckInPageStatus.success,
      ),
    ],
  );
  blocTest<EditCheckInPageCubit, EditCheckInPageState>(
    'Should submit form while updating a new image',
    build: () => sut,
    act: (cubit) {
      cubit.updateImageFile(
        XFile(''),
      );
      cubit.submitForm(
        challengeId: sampleChallengeId,
        exerciseLogId: sampleExerciseLogId,
      );
    },
    skip: 1,
    verify: (cubit) {
      verify(mockUploadRepository.uploadFile(any)).called(1);
      verify(
        mockExerciseLogsRepository.updateExerciseLog(
          challengeId: anyNamed('challengeId'),
          exerciseLogId: anyNamed('exerciseLogId'),
          updateExerciseLogDto: anyNamed('updateExerciseLogDto'),
        ),
      ).called(1);
    },
    expect: () => [
      isA<EditCheckInPageState>().having(
        (state) => state.status,
        'Status',
        EditCheckInPageStatus.loading,
      ),
      isA<EditCheckInPageState>().having(
        (state) => state.status,
        'Status',
        EditCheckInPageStatus.success,
      ),
    ],
  );
  blocTest<EditCheckInPageCubit, EditCheckInPageState>(
    'Should handle expected Application Exception error while submiting the form',
    setUp: () {
      when(
        mockExerciseLogsRepository.updateExerciseLog(
          challengeId: anyNamed('challengeId'),
          exerciseLogId: anyNamed('exerciseLogId'),
          updateExerciseLogDto: anyNamed('updateExerciseLogDto'),
        ),
      ).thenThrow(sampleApplicationException);
    },
    build: () => sut,
    act: (cubit) {
      cubit.submitForm(
        challengeId: sampleChallengeId,
        exerciseLogId: sampleExerciseLogId,
      );
    },
    verify: (cubit) {
      verify(
        mockExerciseLogsRepository.updateExerciseLog(
          challengeId: anyNamed('challengeId'),
          exerciseLogId: anyNamed('exerciseLogId'),
          updateExerciseLogDto: anyNamed('updateExerciseLogDto'),
        ),
      ).called(1);
    },
    expect: () => [
      isA<EditCheckInPageState>().having(
        (state) => state.status,
        'Status',
        EditCheckInPageStatus.loading,
      ),
      isA<EditCheckInPageState>()
          .having(
            (state) => state.status,
            'Status',
            EditCheckInPageStatus.error,
          )
          .having(
            (state) => state.errorMessage,
            'Error message',
            sampleApplicationException.getMessage(),
          ),
    ],
  );
  blocTest<EditCheckInPageCubit, EditCheckInPageState>(
    'Should handle unknown error while submiting the form',
    setUp: () {
      when(
        mockExerciseLogsRepository.updateExerciseLog(
          challengeId: anyNamed('challengeId'),
          exerciseLogId: anyNamed('exerciseLogId'),
          updateExerciseLogDto: anyNamed('updateExerciseLogDto'),
        ),
      ).thenThrow(Error());
    },
    build: () => sut,
    act: (cubit) {
      cubit.submitForm(
        challengeId: sampleChallengeId,
        exerciseLogId: sampleExerciseLogId,
      );
    },
    verify: (cubit) {
      verify(
        mockExerciseLogsRepository.updateExerciseLog(
          challengeId: anyNamed('challengeId'),
          exerciseLogId: anyNamed('exerciseLogId'),
          updateExerciseLogDto: anyNamed('updateExerciseLogDto'),
        ),
      ).called(1);
    },
    expect: () => [
      isA<EditCheckInPageState>().having(
        (state) => state.status,
        'Status',
        EditCheckInPageStatus.loading,
      ),
      isA<EditCheckInPageState>()
          .having(
            (state) => state.status,
            'Status',
            EditCheckInPageStatus.error,
          )
          .having(
            (state) => state.errorMessage,
            'Error message',
            'Unknown error while updating check in',
          ),
    ],
  );
}
