import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/new_check_in_page/new_check_in_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'new_check_in_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UploadRepository>(),
  MockSpec<ExerciseLogsRepository>(),
])
void main() {
  late NewCheckInPageCubit sut;
  late MockExerciseLogsRepository mockExerciseLogsRepository;
  late MockUploadRepository mockUploadRepository;
  final sampleChallengeId = 100;
  setUp(
    () {
      mockUploadRepository = MockUploadRepository();
      mockExerciseLogsRepository = MockExerciseLogsRepository();
      sut = NewCheckInPageCubit(
        exerciseLogsRepositoy: mockExerciseLogsRepository,
        uploadRepository: mockUploadRepository,
      );
    },
  );
  test(
    'Should start with an empty initial state',
    () {
      expect(sut.state.description, '');
      expect(sut.state.title, '');
      expect(sut.state.photo, isNull);
      expect(sut.state.status, NewCheckInPageStatus.idle);
    },
  );
  blocTest<NewCheckInPageCubit, NewCheckInPageState>(
    'Should update title',
    build: () => sut,
    act: (cubit) => cubit.updateTitle('title'),
    expect: () => [
      isA<NewCheckInPageState>().having(
        (state) => state.title,
        'Title',
        'title',
      ),
    ],
  );
  blocTest<NewCheckInPageCubit, NewCheckInPageState>(
    'Should update description',
    build: () => sut,
    act: (cubit) => cubit.updateDescription('description'),
    expect: () => [
      isA<NewCheckInPageState>().having(
        (state) => state.description,
        'Description',
        'description',
      ),
    ],
  );
  blocTest<NewCheckInPageCubit, NewCheckInPageState>(
    'Should update photo file',
    build: () => sut,
    act: (cubit) => cubit.updateImage(XFile('')),
    expect: () => [
      isA<NewCheckInPageState>().having(
        (state) => state.photo,
        'Photo',
        isA<XFile>(),
      ),
    ],
  );
  blocTest<NewCheckInPageCubit, NewCheckInPageState>(
    'Should submit form with an image',
    build: () => sut,
    act: (cubit) {
      cubit.updateImage(XFile(''));
      cubit.submitForm(sampleChallengeId);
    },
    skip: 1,
    expect: () => [
      isA<NewCheckInPageState>().having(
        (state) => state.status,
        'Status',
        NewCheckInPageStatus.loading,
      ),
      isA<NewCheckInPageState>().having(
        (state) => state.status,
        'Status',
        NewCheckInPageStatus.success,
      ),
    ],
  );
  blocTest<NewCheckInPageCubit, NewCheckInPageState>(
    'Should handle Exception while submiting the form',
    build: () => sut,
    setUp: () {
      when(
        mockExerciseLogsRepository.addExerciseLogToChallenge(
          sampleChallengeId,
          any,
        ),
      ).thenThrow(
        Error(),
      );
    },
    act: (cubit) {
      cubit.submitForm(sampleChallengeId);
    },

    expect: () => [
      isA<NewCheckInPageState>().having(
        (state) => state.status,
        'Status',
        NewCheckInPageStatus.loading,
      ),
      isA<NewCheckInPageState>().having(
        (state) => state.status,
        'Status',
        NewCheckInPageStatus.failed,
      ),
    ],
  );
}
