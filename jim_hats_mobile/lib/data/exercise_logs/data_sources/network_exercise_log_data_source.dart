import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:jim_hats_mobile/data/settings/models/settings.dart';
import 'package:jim_hats_mobile/shared/http/http_client.dart';

class NetworkExerciseLogDataSource implements ExerciseLogDataSource {
  final HttpClient _httpClient;
  final SettingsDataSource _settingsDataSource;
  NetworkExerciseLogDataSource({
    required SettingsDataSource settingsDataSource,
    required HttpClient httpClient,
  })  : _settingsDataSource = settingsDataSource,
        _httpClient = httpClient;
  @override
  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId) async {
    try {
      final jwtToken = await _settingsDataSource.get<String>('token');
      final response = await _httpClient.dio
          .get<Map<String, dynamic>>('/gym-challenges/$challengeId/logs',
          
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      final data = response.data?['data'] as List;
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
