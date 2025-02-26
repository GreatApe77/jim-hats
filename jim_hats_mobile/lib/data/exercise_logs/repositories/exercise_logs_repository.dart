import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/add_exercise_log_to_challenge_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/core/utils/memory_cache.dart';

class ExerciseLogsRepository {
  final ExerciseLogDataSource _exerciseLogDataSource;

  ExerciseLogsRepository(
      {required ExerciseLogDataSource? exerciseLogDataSource})
      : _exerciseLogDataSource =
            exerciseLogDataSource ?? locator.get<ExerciseLogDataSource>();

  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId) async {
    //await Future.delayed(Duration(milliseconds: 1500));

    // final logs = await _exerciseLogDataSource.getLogsOfChallenge(challengeId);
    // return logs;
    List<ExerciseLogWithUser>? logsOfChallenge =
        MemoryCache.get<List<ExerciseLogWithUser>>('logs-$challengeId');
    if (logsOfChallenge == null) {
      logsOfChallenge =
          await _exerciseLogDataSource.getLogsOfChallenge(challengeId);
      MemoryCache.store<List<ExerciseLogWithUser>>(
          'logs-$challengeId', logsOfChallenge);
    }
    return logsOfChallenge;
  }

  Future<void> addExerciseLogToChallenge(int challengeId,
      AddExerciseLogToChallengeDto addExerciseLogToChallengeDto) async {
    try {
      print(addExerciseLogToChallengeDto.toMap());
      await _exerciseLogDataSource.addExerciseLogToChallenge(
          challengeId, addExerciseLogToChallengeDto);
      MemoryCache.remove('logs-$challengeId');
    } catch (e) {
      rethrow;
    }
  }
}
