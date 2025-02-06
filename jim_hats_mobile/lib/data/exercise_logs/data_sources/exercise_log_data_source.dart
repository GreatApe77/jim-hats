import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';

abstract class ExerciseLogDataSource {
  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId);
}