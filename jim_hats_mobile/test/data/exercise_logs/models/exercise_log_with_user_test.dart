import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';

void main() {
  final sampleUser = User(
    username: 'mateus',
    profilePicture: 'https://profilepicture.com',
  );
  final sampleExerciseLogWithUser = ExerciseLogWithUser(
    user: sampleUser,
    id: 1,
    title: 'Morning Run',
    description: 'Ran 5km in the park',
    image: 'http://example.com/image.jpg',
    date: DateTime(2025, 3, 27),
    userId: 101,
    gymChallengeId: 202,
  );
  group(
    'User',
    () {
      test(
        'Should copyWith',
        () {
          final copiedWithProps = sampleUser.copyWith(
            username: 'jonas',
          );
          expect(copiedWithProps.profilePicture, sampleUser.profilePicture);
          expect(copiedWithProps.username, 'jonas');
        },
      );
      test(
        'Should transform to Map',
        () {
          final generatedMap = sampleUser.toMap();
          expect(generatedMap['username'], sampleUser.username);
          expect(generatedMap['profilePicture'], sampleUser.profilePicture);
        },
      );
      test(
        'Should transform to a visible string representation',
        () {
          final stringUser = sampleUser.toString();
          expect(stringUser,
              'User(username: ${sampleUser.username}, profilePicture: ${sampleUser.profilePicture})');
        },
      );
      test(
        'Should return a User model from a json string',
        () {
          final json =
              '{"username":"john_doe","profilePicture":"http://example.com/profile.jpg"}';
          final user = User.fromJson(json);
          expect(user.username, 'john_doe');
          expect(user.profilePicture, 'http://example.com/profile.jpg');
        },
      );
      test(
        'Should test equality',
        () {
          final equalUser = User.fromMap(
            sampleUser.toMap(),
          );
          expect(equalUser, sampleUser);
        },
      );
      test('hashCode returns correct hash code', () {
        final hashCode = sampleUser.hashCode;

        expect(hashCode,
            sampleUser.username.hashCode ^ sampleUser.profilePicture.hashCode);
      });
    },
  );
  group(
    'Exercise log with user',
    () {
      test('toMap converts ExerciseLogWithUser to a map', () {
        final map = sampleExerciseLogWithUser.toMap();

        expect(map['id'], sampleExerciseLogWithUser.id);
        expect(map['title'], sampleExerciseLogWithUser.title);
        expect(map['description'], sampleExerciseLogWithUser.description);
        expect(map['image'], sampleExerciseLogWithUser.image);
        expect(
            map['date'], sampleExerciseLogWithUser.date.millisecondsSinceEpoch);
        expect(map['userId'], sampleExerciseLogWithUser.userId);
        expect(map['gymChallengeId'], sampleExerciseLogWithUser.gymChallengeId);
        expect(map['user'], sampleUser.toMap());
      });
      test(
        'Should conver to json String',
        () {
          final result = sampleExerciseLogWithUser.toJson();
          expect(result, isA<String>());
        },
      );
    },
  );
}
