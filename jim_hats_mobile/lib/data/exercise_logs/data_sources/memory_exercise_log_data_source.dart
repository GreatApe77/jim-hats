import 'dart:math';

import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/add_exercise_log_to_challenge_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';

final  dayInMiliseconds = 8.64 *pow(10,7);
class MemoryExerciseLogDataSource  implements ExerciseLogDataSource{
  @override
  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId) {
return Future.value([
      ExerciseLogWithUser.fromMap({
        'id': 1,
        'title': 'Morning Run',
        'description': '5km run in the park',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch-dayInMiliseconds.toInt()*13,
        'userId': 1,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'john_doe',
          'profilePicture': null,
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 2,
        'title': 'Weight Lifting',
        'description': 'Chest and triceps workout',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch-dayInMiliseconds.toInt()*12,
        'userId': 2,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'jane_smith',
          'profilePicture': null,
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 3,
        'title': 'Yoga Session',
        'description': '1-hour yoga class',
        'image': 'https://avatars.githubusercontent.com/u/99892495?s=200&v=4',
        'date': DateTime.now().millisecondsSinceEpoch-dayInMiliseconds.toInt()*11,
        'userId': 3,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'alice_jones',
          'profilePicture': 'https://avatars.githubusercontent.com/u/99892395?s=200&v=4',
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 4,
        'title': 'Cycling',
        'description': '20km cycling route',
        'image': 'https://avatars.githubusercontent.com/u/99892494?s=200&v=4',
        'date': DateTime.now().millisecondsSinceEpoch-dayInMiliseconds.toInt()*10,
        'userId': 4,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'bob_brown',
          'profilePicture': 'https://avatars.githubusercontent.com/u/97892495?s=200&v=4',
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 5,
        'title': 'Swimming',
        'description': '30 minutes of swimming',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch-dayInMiliseconds.toInt()*10, //10 days ago
        'userId': 5,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'charlie_davis',
          'profilePicture': 'https://avatars.githubusercontent.com/u/99892595?s=200&v=4',
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 6,
        'title': 'HIIT Workout',
        'description': 'High-intensity interval training',
        'image': 'https://avatars.githubusercontent.com/u/99892494?s=200&v=4',
        'date': DateTime.now().millisecondsSinceEpoch-dayInMiliseconds.toInt(),
        'userId': 6,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'diana_evans',
          'profilePicture': null,
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 7,
        'title': 'Pilates',
        'description': 'Pilates class',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch-dayInMiliseconds.toInt(),
        'userId': 7,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'frank_green',
          'profilePicture': null,
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 8,
        'title': 'Boxing',
        'description': 'Boxing training session',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch,
        'userId': 8,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'george_hill',
          'profilePicture': null,
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 9,
        'title': 'Dance Class',
        'description': 'Zumba dance class',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch,
        'userId': 9,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'hannah_lee',
          'profilePicture': null,
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 10,
        'title': 'Rock Climbing',
        'description': 'Indoor rock climbing session',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch,
        'userId': 10,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'ian_martin',
          'profilePicture': null,
        },
      }),
    ]);
  }

  @override
  Future<void> addExerciseLogToChallenge(int challengeId, AddExerciseLogToChallengeDto addExerciseLogToChallengeDto) {
    // TODO: implement addExerciseLogToChallenge
    throw UnimplementedError();
  }

  @override
  Future<List<ExerciseLog>> getAllLogsOfUser() {
    // TODO: implement getAllLogsOfUser
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteExerciseLog(int exerciseLogId) {
    // TODO: implement deleteExerciseLog
    throw UnimplementedError();
  }
  

}