import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/check_in_page/check_in_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_in_page_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ExerciseLogsRepository>()])
void main() {
  late CheckInPageCubit sut;
  late MockExerciseLogsRepository mockExerciseLogsRepository;
  final sampleChallengeId = 7;
  final sampleExerciseLogId = 8;
  final sampleApplicationException = TimeOutException();
  setUp(
    () {
      mockExerciseLogsRepository = MockExerciseLogsRepository();
      sut = CheckInPageCubit(
        exerciseLogsRepository: mockExerciseLogsRepository,
      );
    },
  );

  test(
    'Should have empty initial state',
    () => expect(
      sut.state,
      isA<CheckInPageInitial>(),
    ),
  );

  blocTest<CheckInPageCubit, CheckInPageState>(
    'Should delete a check in by calling the Exercise log repository',
    build: () => sut,
    act: (cubit) => cubit.deleteCheckIn(
      challengeId: sampleChallengeId,
      exerciseLogId: sampleExerciseLogId,
    ),
    expect: () => [
      isA<CheckInPageLoading>(),
      isA<CheckInPageSuccess>(),
    ],
  );
  blocTest<CheckInPageCubit, CheckInPageState>(
    'Should fail to delete and catch an application exception',
    build: () => sut,
    setUp: () {
      when(
        mockExerciseLogsRepository.deleteExerciseLog(
          sampleExerciseLogId,
          sampleChallengeId,
        ),
      ).thenThrow(
        sampleApplicationException,
      );
    },
    act: (cubit) => cubit.deleteCheckIn(
      challengeId: sampleChallengeId,
      exerciseLogId: sampleExerciseLogId,
    ),
    expect: () => [
      isA<CheckInPageLoading>(),
      isA<CheckInPageError>().having(
        (state) => state.errorMessage,
        'Error message',
        sampleApplicationException.getMessage(),
      ),
    ],
  );
   blocTest<CheckInPageCubit, CheckInPageState>(
    'Should fail to delete and catch an unknown exception',
    build: () => sut,
    setUp: () {
      when(
        mockExerciseLogsRepository.deleteExerciseLog(
          sampleExerciseLogId,
          sampleChallengeId,
        ),
      ).thenThrow(
        Error(),
      );
    },
    act: (cubit) => cubit.deleteCheckIn(
      challengeId: sampleChallengeId,
      exerciseLogId: sampleExerciseLogId,
    ),
    expect: () => [
      isA<CheckInPageLoading>(),
      isA<CheckInPageError>().having(
        (state) => state.errorMessage,
        'Error message',
        'Unknown error while deleting exercise log',
      ),
    ],
  );
}
