import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';

class ExerciseLogsRepository {
  final ExerciseLogDataSource _exerciseLogDataSource;

  ExerciseLogsRepository({required ExerciseLogDataSource exerciseLogDataSource})
      : _exerciseLogDataSource = exerciseLogDataSource;

  
  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId) async {
    await Future.delayed(Duration(milliseconds: 1500));
    final logs = await _exerciseLogDataSource.getLogsOfChallenge(challengeId);
    return logs;
  }
}
