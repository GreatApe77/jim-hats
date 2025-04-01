import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';

void main() {
  group('GymChallenge', () {
    final gymChallenge = GymChallenge(
      id: 1,
      name: 'Fitness Challenge',
      description: 'A challenge to improve fitness',
      image: 'http://example.com/image.jpg',
      joinId: 'ABC123',
      createdAt: DateTime(2025, 3, 27),
      startAt: DateTime(2025, 4, 1),
      endAt: DateTime(2025, 4, 30),
      creatorId: 101,
    );

    test('copyWith creates a new instance with updated values', () {
      final updatedGymChallenge = gymChallenge.copyWith(
        name: 'New Fitness Challenge',
        description: 'An updated challenge description',
      );

      expect(updatedGymChallenge.name, 'New Fitness Challenge');
      expect(
          updatedGymChallenge.description, 'An updated challenge description');
      expect(updatedGymChallenge.id, gymChallenge.id); // unchanged
      expect(
          updatedGymChallenge.createdAt, gymChallenge.createdAt); // unchanged
    });
    test('Should copyWith with the same values',() {
      final copied = gymChallenge.copyWith();
      expect(copied, gymChallenge);
    },);
    test('toMap converts GymChallenge to a map', () {
      final map = gymChallenge.toMap();

      expect(map['id'], gymChallenge.id);
      expect(map['name'], gymChallenge.name);
      expect(map['description'], gymChallenge.description);
      expect(map['image'], gymChallenge.image);
      expect(map['joinId'], gymChallenge.joinId);
      expect(map['createdAt'], gymChallenge.createdAt.millisecondsSinceEpoch);
      expect(map['startAt'], gymChallenge.startAt.millisecondsSinceEpoch);
      expect(map['endAt'], gymChallenge.endAt.millisecondsSinceEpoch);
      expect(map['creatorId'], gymChallenge.creatorId);
    });

    test('fromMap creates GymChallenge from a map', () {
      final map = {
        'id': 1,
        'name': 'Fitness Challenge',
        'description': 'A challenge to improve fitness',
        'image': 'http://example.com/image.jpg',
        'joinId': 'ABC123',
        'createdAt': DateTime(2025, 3, 27).millisecondsSinceEpoch,
        'startAt': DateTime(2025, 4, 1).millisecondsSinceEpoch,
        'endAt': DateTime(2025, 4, 30).millisecondsSinceEpoch,
        'creatorId': 101,
      };

      final fromMapGymChallenge = GymChallenge.fromMap(map);

      expect(fromMapGymChallenge, gymChallenge);
    });

    test('toJson converts GymChallenge to JSON string', () {
      final json = gymChallenge.toJson();

      expect(json,
          '{"id":1,"name":"Fitness Challenge","description":"A challenge to improve fitness","image":"http://example.com/image.jpg","joinId":"ABC123","createdAt":1743044400000,"startAt":1743476400000,"endAt":1745982000000,"creatorId":101}');
    });

    test('fromJson creates GymChallenge from JSON string', () {
      final json =
          '{"id":1,"name":"Fitness Challenge","description":"A challenge to improve fitness","image":"http://example.com/image.jpg","joinId":"ABC123","createdAt":1743044400000,"startAt":1743476400000,"endAt":1745982000000,"creatorId":101}';

      final fromJsonGymChallenge = GymChallenge.fromJson(json);

      expect(fromJsonGymChallenge, gymChallenge);
    });

    test('toString returns correct string representation', () {
      final string = gymChallenge.toString();

      expect(string,
          'GymChallenge(id: 1, name: Fitness Challenge, description: A challenge to improve fitness, image: http://example.com/image.jpg, joinId: ABC123, createdAt: 2025-03-27 00:00:00.000, startAt: 2025-04-01 00:00:00.000, endAt: 2025-04-30 00:00:00.000, creatorId: 101)');
    });

    test('equality operator returns true for identical objects', () {
      final identicalGymChallenge = GymChallenge(
        id: 1,
        name: 'Fitness Challenge',
        description: 'A challenge to improve fitness',
        image: 'http://example.com/image.jpg',
        joinId: 'ABC123',
        createdAt: DateTime(2025, 3, 27),
        startAt: DateTime(2025, 4, 1),
        endAt: DateTime(2025, 4, 30),
        creatorId: 101,
      );

      expect(gymChallenge == identicalGymChallenge, true);
    });

    test('hashCode returns correct hash code', () {
      final hashCode = gymChallenge.hashCode;

      expect(
          hashCode,
          gymChallenge.id.hashCode ^
              gymChallenge.name.hashCode ^
              gymChallenge.description.hashCode ^
              gymChallenge.image.hashCode ^
              gymChallenge.joinId.hashCode ^
              gymChallenge.createdAt.hashCode ^
              gymChallenge.startAt.hashCode ^
              gymChallenge.endAt.hashCode ^
              gymChallenge.creatorId.hashCode);
    });
  });
}
