import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';

void main() {
  group('ExerciseLog', () {
    final exerciseLog = ExerciseLog(
      id: 1,
      title: 'Morning Run',
      description: 'Ran 5km in the park',
      image: 'http://example.com/image.jpg',
      date: DateTime(2025, 3, 27),
      userId: 101,
      gymChallengeId: 202,
    );

    test('Should create a new instance with updated values', () {
      final updatedExerciseLog = exerciseLog.copyWith(
        title: 'Evening Run',
        description: 'Ran 10km in the park',
      );

      expect(updatedExerciseLog.title, 'Evening Run');
      expect(updatedExerciseLog.description, 'Ran 10km in the park');
      expect(updatedExerciseLog.id, exerciseLog.id);
      expect(updatedExerciseLog.date, exerciseLog.date);
    });
    test('Should copyWith the same values', () {
      final updatedExerciseLog = exerciseLog.copyWith();

      expect(updatedExerciseLog, exerciseLog);
    });

    test('Should convert to map', () {
      final map = exerciseLog.toMap();

      expect(map['id'], exerciseLog.id);
      expect(map['title'], exerciseLog.title);
      expect(map['description'], exerciseLog.description);
      expect(map['image'], exerciseLog.image);
      expect(map['date'], exerciseLog.date.millisecondsSinceEpoch);
      expect(map['userId'], exerciseLog.userId);
      expect(map['gymChallengeId'], exerciseLog.gymChallengeId);
    });

    test('Should create exercise log from a map', () {
      final map = {
        'id': 1,
        'title': 'Morning Run',
        'description': 'Ran 5km in the park',
        'image': 'http://example.com/image.jpg',
        'date': DateTime(2025, 3, 27).millisecondsSinceEpoch,
        'userId': 101,
        'gymChallengeId': 202,
      };

      final fromMapExerciseLog = ExerciseLog.fromMap(map);

      expect(fromMapExerciseLog, exerciseLog);
    });

    test('Should convert model to json string', () {
      final json = exerciseLog.toJson();

      expect(json,
          '{"id":1,"title":"Morning Run","description":"Ran 5km in the park","image":"http://example.com/image.jpg","date":1743044400000,"userId":101,"gymChallengeId":202}');
    });

    test('Should convert json string to model', () {
      final json =
          '{"id":1,"title":"Morning Run","description":"Ran 5km in the park","image":"http://example.com/image.jpg","date":1743044400000,"userId":101,"gymChallengeId":202}';

      final fromJsonExerciseLog = ExerciseLog.fromJson(json);

      expect(fromJsonExerciseLog.title, exerciseLog.title);
    });

    test('Should be a readable toString()', () {
      final string = exerciseLog.toString();

      expect(string,
          'ExerciseLog(id: 1, title: Morning Run, description: Ran 5km in the park, image: http://example.com/image.jpg, date: 2025-03-27 00:00:00.000, userId: 101, gymChallengeId: 202)');
    });

    test('Should test equality of props', () {
      final identicalExerciseLog = ExerciseLog(
        id: 1,
        title: 'Morning Run',
        description: 'Ran 5km in the park',
        image: 'http://example.com/image.jpg',
        date: DateTime(2025, 3, 27),
        userId: 101,
        gymChallengeId: 202,
      );

      expect(exerciseLog == identicalExerciseLog, true);
    });

    test('Should  return correct hash code', () {
      final hashCode = exerciseLog.hashCode;

      expect(
          hashCode,
          exerciseLog.id.hashCode ^
              exerciseLog.title.hashCode ^
              exerciseLog.description.hashCode ^
              exerciseLog.image.hashCode ^
              exerciseLog.date.hashCode ^
              exerciseLog.userId.hashCode ^
              exerciseLog.gymChallengeId.hashCode);
    });
  });
}
