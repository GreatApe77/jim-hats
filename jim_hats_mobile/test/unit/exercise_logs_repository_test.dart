import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/cache_service.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/add_exercise_log_to_challenge_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/update_exercise_log_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exercise_logs_repository_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<ExerciseLogDataSource>(), MockSpec<CacheService>()])
void main() {
  late ExerciseLogsRepository sut;
  late ExerciseLogDataSource mockExerciseLogDataSource;
  late CacheService mockCacheService;
  final sampleChallengeId = 8;
  final sampleExerciseLogId = 20;
  final sampleAddExerciseLogToChallengeDto = AddExerciseLogToChallengeDto(
    title: 'Sample title',
    description: 'description',
    image: 'https://pathtoimage',
  );
  final sampleUpdateExerciseLogDto = UpdateExerciseLogDto(
    description: 'UPDATED',
  );
  final sampleExerciseLogWithUserList = [
    ExerciseLogWithUser(
      user: User(username: 'username'),
      id: 3,
      title: 'title',
      date: DateTime(2025),
      userId: 5,
      gymChallengeId: sampleChallengeId,
    )
  ];
  final sampleExerciseLogList = [
    ExerciseLog(
      id: 1,
      title: 'title',
      date: DateTime(2025),
      userId: 5,
      gymChallengeId: sampleChallengeId,
    ),
    ExerciseLog(
      id: 3,
      title: 'title 3',
      date: DateTime(2024),
      userId: 5,
      gymChallengeId: sampleChallengeId,
    )
  ];

  setUp(
    () {
      mockCacheService = MockCacheService();
      mockExerciseLogDataSource = MockExerciseLogDataSource();
      sut = ExerciseLogsRepository(
        exerciseLogDataSource: mockExerciseLogDataSource,
        cacheService: mockCacheService,
      );
    },
  );

  group(
    'Add exercise log to challenge',
    () {
      test(
        'Should add an exercise log to a challenge',
        () async {
          await expectLater(
            sut.addExerciseLogToChallenge(
              sampleChallengeId,
              sampleAddExerciseLogToChallengeDto,
            ),
            completes,
          );
          verifyInOrder([
            mockExerciseLogDataSource.addExerciseLogToChallenge(
              sampleChallengeId,
              sampleAddExerciseLogToChallengeDto,
            ),
            mockCacheService.remove('logs-$sampleChallengeId'),
          ]);
        },
      );
    },
  );

  group(
    'Get all exercise logs of a user',
    () {
      test(
        'Should get all exercise logs of a user (cache hit)',
        () async {
          when(mockCacheService.get<List<ExerciseLog>>('user-logs'))
              .thenReturn(sampleExerciseLogList);
          final result = await sut.getAllExerciseLogsOfUser();
          expect(result, isA<List<ExerciseLog>>());
          expect(result.length, 2);
          expect(result[0].title, 'title');
        },
      );
      test(
        'Should get all exercise logs of a user (cache miss)',
        () async {
          when(mockCacheService.get<List<ExerciseLog>>('user-logs'))
              .thenReturn(null);
          when(
            mockExerciseLogDataSource.getAllLogsOfUser(),
          ).thenAnswer(
            (_) async => sampleExerciseLogList,
          );
          final result = await sut.getAllExerciseLogsOfUser();
          expect(result, isA<List<ExerciseLog>>());
          expect(result.length, 2);
          expect(result[0].title, 'title');
        },
      );
    },
  );

  group(
    'Delete exercise log',
    () {
      test(
        'Should delete exercise log',
        () async {
          await expectLater(
            sut.deleteExerciseLog(
              sampleExerciseLogId,
              sampleChallengeId,
            ),
            completes,
          );
          verifyInOrder([
            mockExerciseLogDataSource.deleteExerciseLog(sampleExerciseLogId),
            mockCacheService.remove('logs-$sampleChallengeId')
          ]);
        },
      );
    },
  );

  group(
    'Update exercise log',
    () {
      test(
        'Should update exercise log clearing the cache',
        () async {
          await expectLater(
            sut.updateExerciseLog(
              challengeId: sampleChallengeId,
              exerciseLogId: sampleExerciseLogId,
              updateExerciseLogDto: sampleUpdateExerciseLogDto,
            ),
            completes,
          );
          verifyInOrder([
            mockExerciseLogDataSource.updateExerciseLog(
                sampleExerciseLogId, sampleUpdateExerciseLogDto),
            mockCacheService.remove('logs-$sampleChallengeId')
          ]);
        },
      );
    },
  );
  group(
    'Get logs of challenge',
    () {
      test(
        'Should get all logs of a challenge (cache hit)',
        () async {
          when(
            mockCacheService
                .get<List<ExerciseLogWithUser>>('logs-$sampleChallengeId'),
          ).thenReturn(sampleExerciseLogWithUserList);
          final result = await sut.getLogsOfChallenge(sampleChallengeId);
          expect(result, isA<List<ExerciseLogWithUser>>());
          expect(result.length, 1);
          expect(result[0].title, 'title');
        },
      );
      test(
        'Should get all logs of a challenge (cache miss)',
        () async {
          when(
            mockCacheService
                .get<List<ExerciseLogWithUser>>('logs-$sampleChallengeId'),
          ).thenReturn(null);
          when(
            mockExerciseLogDataSource.getLogsOfChallenge(sampleChallengeId),
          ).thenAnswer(
            (_) async => sampleExerciseLogWithUserList,
          );
          final result = await sut.getLogsOfChallenge(sampleChallengeId);

          expect(result, isA<List<ExerciseLogWithUser>>());
          expect(result.length, 1);
          expect(result[0].title, 'title');
        },
      );
    },
  );
}
