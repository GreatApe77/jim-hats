import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';

class MemoryExerciseLogDataSource  implements ExerciseLogDataSource{
  @override
  Future<List<ExerciseLogWithUser>> getLogsOfChallenge(int challengeId) {
return Future.value([
      ExerciseLogWithUser.fromMap({
        'id': 1,
        'title': 'Morning Run',
        'description': '5km run in the park',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch,
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
        'date': DateTime.now().millisecondsSinceEpoch,
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
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch,
        'userId': 3,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'alice_jones',
          'profilePicture': null,
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 4,
        'title': 'Cycling',
        'description': '20km cycling route',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch,
        'userId': 4,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'bob_brown',
          'profilePicture': null,
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 5,
        'title': 'Swimming',
        'description': '30 minutes of swimming',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch,
        'userId': 5,
        'gymChallengeId': challengeId,
        'user': {
          'username': 'charlie_davis',
          'profilePicture': null,
        },
      }),
      ExerciseLogWithUser.fromMap({
        'id': 6,
        'title': 'HIIT Workout',
        'description': 'High-intensity interval training',
        'image': null,
        'date': DateTime.now().millisecondsSinceEpoch,
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
        'date': DateTime.now().millisecondsSinceEpoch,
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
}