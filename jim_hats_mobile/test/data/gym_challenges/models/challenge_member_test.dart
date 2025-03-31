import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';

void main() {
  group('ChallengeMember', () {
    final challengeMember = ChallengeMember(
      id: 1,
      username: 'john_doe',
      profilePicture: 'http://example.com/profile.jpg',
    );

    test('copyWith creates a new instance with updated values', () {
      final updatedChallengeMember = challengeMember.copyWith(
        username: 'jane_doe',
        profilePicture: 'http://example.com/new_profile.jpg',
      );

      expect(updatedChallengeMember.username, 'jane_doe');
      expect(updatedChallengeMember.profilePicture,
          'http://example.com/new_profile.jpg');
      expect(updatedChallengeMember.id, challengeMember.id); // unchanged
    });

    test('toMap converts ChallengeMember to a map', () {
      final map = challengeMember.toMap();

      expect(map['id'], challengeMember.id);
      expect(map['username'], challengeMember.username);
      expect(map['profilePicture'], challengeMember.profilePicture);
    });

    test('fromMap creates ChallengeMember from a map', () {
      final map = {
        'id': 1,
        'username': 'john_doe',
        'profilePicture': 'http://example.com/profile.jpg',
      };

      final fromMapChallengeMember = ChallengeMember.fromMap(map);

      expect(fromMapChallengeMember, challengeMember);
    });

    test('toJson converts ChallengeMember to JSON string', () {
      final json = challengeMember.toJson();

      expect(json,
          '{"id":1,"username":"john_doe","profilePicture":"http://example.com/profile.jpg"}');
    });

    test('fromJson creates ChallengeMember from JSON string', () {
      final json =
          '{"id":1,"username":"john_doe","profilePicture":"http://example.com/profile.jpg"}';

      final fromJsonChallengeMember = ChallengeMember.fromJson(json);

      expect(fromJsonChallengeMember, challengeMember);
    });

    test('toString returns correct string representation', () {
      final string = challengeMember.toString();

      expect(string,
          'ChallengeMember(id: 1, username: john_doe, profilePicture: http://example.com/profile.jpg)');
    });

    test('equality operator returns true for identical objects', () {
      final identicalChallengeMember = ChallengeMember(
        id: 1,
        username: 'john_doe',
        profilePicture: 'http://example.com/profile.jpg',
      );

      expect(challengeMember == identicalChallengeMember, true);
    });

    test('hashCode returns correct hash code', () {
      final hashCode = challengeMember.hashCode;

      expect(
          hashCode,
          challengeMember.id.hashCode ^
              challengeMember.username.hashCode ^
              challengeMember.profilePicture.hashCode);
    });
  });
}
