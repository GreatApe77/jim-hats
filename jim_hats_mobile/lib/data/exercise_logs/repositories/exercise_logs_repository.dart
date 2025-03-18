import 'package:jim_hats_mobile/core/utils/cache_service.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/add_exercise_log_to_challenge_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/update_exercise_log_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/core/utils/memory_cache.dart';

class ExerciseLogsRepository {
  final ExerciseLogDataSource _exerciseLogDataSource;
  final CacheService _cacheService;
  ExerciseLogsRepository(
      {required ExerciseLogDataSource? exerciseLogDataSource,
      
      required CacheService cacheService
      })
      :
      _cacheService=cacheService,
       _exerciseLogDataSource =
            exerciseLogDataSource ?? locator.get<ExerciseLogDataSource>();

  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId) async {
    //await Future.delayed(Duration(milliseconds: 1500));

    // final logs = await _exerciseLogDataSource.getLogsOfChallenge(challengeId);
    // return logs;
    List<ExerciseLogWithUser>? logsOfChallenge =
        _cacheService.get<List<ExerciseLogWithUser>>('logs-$challengeId');
    if (logsOfChallenge == null) {
      logsOfChallenge =
          await _exerciseLogDataSource.getLogsOfChallenge(challengeId);
      _cacheService.store<List<ExerciseLogWithUser>>(
          'logs-$challengeId', logsOfChallenge);
    }
    return logsOfChallenge;
  }

  Future<void> addExerciseLogToChallenge(
    int challengeId,
    AddExerciseLogToChallengeDto addExerciseLogToChallengeDto,
  ) async {
    try {
      //print(addExerciseLogToChallengeDto.toMap());
      await _exerciseLogDataSource.addExerciseLogToChallenge(
          challengeId, addExerciseLogToChallengeDto);
      _cacheService.remove('logs-$challengeId');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ExerciseLog>> getAllExerciseLogsOfUser() async {
    final String key = 'user-logs';
    List<ExerciseLog>? userLogs = _cacheService.get<List<ExerciseLog>>(key);
    if (userLogs == null) {
      userLogs = await _exerciseLogDataSource.getAllLogsOfUser();
      _cacheService.store<List<ExerciseLog>>(key, userLogs,
          duration: Duration(minutes: 1));
    }
    return userLogs;
  }

  Future<void> deleteExerciseLog(int exerciseLogId, int challengeId) async {
    try {
      //print(addExerciseLogToChallengeDto.toMap());
      await _exerciseLogDataSource.deleteExerciseLog(
        exerciseLogId,
      );
      _cacheService.remove('logs-$challengeId');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateExerciseLog({
    required int challengeId,
    required int exerciseLogId,
    required UpdateExerciseLogDto updateExerciseLogDto,
  }) async {
    try {
      //print(addExerciseLogToChallengeDto.toMap());
      await _exerciseLogDataSource.updateExerciseLog(
        exerciseLogId,
        updateExerciseLogDto,
      );
      _cacheService.remove('logs-$challengeId');
    } catch (e) {
      rethrow;
    }
  }
}
