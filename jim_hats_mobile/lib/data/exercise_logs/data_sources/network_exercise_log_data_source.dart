import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/add_exercise_log_to_challenge_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/update_exercise_log_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';

class NetworkExerciseLogDataSource implements ExerciseLogDataSource {
  final HttpService _httpClient;

  NetworkExerciseLogDataSource({
    required HttpService httpClient,
  }) : _httpClient = httpClient;
  @override
  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId) async {
    final response = await _httpClient.get(
      '/gym-challenges/$challengeId/logs',
    );
    final data = response['data'] as List;
    return data
        .map(
          (e) => ExerciseLogWithUser.fromMap(e),
        )
        .toList();
  }

  @override
  Future<void> addExerciseLogToChallenge(int challengeId,
      AddExerciseLogToChallengeDto addExerciseLogToChallengeDto) async {
    await _httpClient.post(
      data: addExerciseLogToChallengeDto.toMap(),
      '/gym-challenges/$challengeId/logs',
    );
  }

  @override
  Future<List<ExerciseLog>> getAllLogsOfUser() async {
    final response = await _httpClient.get(
      '/users/me/logs',
    );
    final data = response['data'] as List;
    return data
        .map(
          (e) => ExerciseLog.fromMap(e),
        )
        .toList();
  }

  @override
  Future<void> deleteExerciseLog(int exerciseLogId) async {
    await _httpClient.delete('/logs/$exerciseLogId');
  }

  @override
  Future<void> updateExerciseLog(
    int exerciseLogId,
    UpdateExerciseLogDto updateExerciseLogDto,
  ) async {
    try {
      await _httpClient.patch(
        '/logs/$exerciseLogId',
        data: updateExerciseLogDto.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
