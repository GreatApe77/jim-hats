import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/shared/http/http_client.dart';

class NetworkExerciseLogDataSource implements ExerciseLogDataSource {
  final HttpClient _httpClient;

  NetworkExerciseLogDataSource({required HttpClient httpClient})
      : _httpClient = httpClient;
  @override
  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId) async {
    try {
      final response = await _httpClient.dio
          .get<Map<String, dynamic>>('/gym-challenges/$challengeId/logs');
      final data = response.data?['data'] as List;
      print(data);
      return data
          .map(
            (e) => ExerciseLogWithUser.fromMap(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
