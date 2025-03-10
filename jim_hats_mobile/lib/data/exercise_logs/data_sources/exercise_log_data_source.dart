import 'package:jim_hats_mobile/data/exercise_logs/dtos/add_exercise_log_to_challenge_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/data/logged_user/dtos/update_logged_user_dto.dart';

abstract class ExerciseLogDataSource {
  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId);
  Future<void> addExerciseLogToChallenge(int challengeId,AddExerciseLogToChallengeDto addExerciseLogToChallengeDto);
  Future<List<ExerciseLog>> getAllLogsOfUser();
  Future<void> deleteExerciseLog(int exerciseLogId);
  Future<void> updateExerciseLog( int exerciseLogId,UpdateLoggedUserDto updateExerciseLogDto);
}