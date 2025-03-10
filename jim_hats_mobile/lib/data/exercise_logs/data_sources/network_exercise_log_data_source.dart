import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/add_exercise_log_to_challenge_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';

class NetworkExerciseLogDataSource implements ExerciseLogDataSource {
  final HttpService _httpClient;

  NetworkExerciseLogDataSource({
    
    required HttpService httpClient,
  }) : _httpClient = httpClient;
  @override
  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId) async {
    try {
      final response = await _httpClient.get(
        '/gym-challenges/$challengeId/logs',
      );
      final data = response['data'] as List;
      return data
          .map(
            (e) => ExerciseLogWithUser.fromMap(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addExerciseLogToChallenge(int challengeId,
      AddExerciseLogToChallengeDto addExerciseLogToChallengeDto) async {
    try {
      await _httpClient.post(
        data: addExerciseLogToChallengeDto.toMap(),
        '/gym-challenges/$challengeId/logs',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ExerciseLog>> getAllLogsOfUser() async {
    try {
      final response = await _httpClient.get(
        '/users/me/logs',
      );
      final data = response['data'] as List;
      return data
          .map(
            (e) => ExerciseLog.fromMap(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> deleteExerciseLog(int exerciseLogId) async {
    try {
      await _httpClient.delete('/log/$exerciseLogId');
    } catch (e) {
      rethrow;
    }
  }
}
