import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';

void main() {
  group('Ranking', () {
    final ranking = Ranking(
      id: 1,
      username: 'john_doe',
      profilePicture: 'http://example.com/profile.jpg',
      logCount: 42,
    );

    test('copyWith creates a new instance with updated values', () {
      final updatedRanking = ranking.copyWith(
        username: 'jane_doe',
        profilePicture: 'http://example.com/new_profile.jpg',
        logCount: 50,
      );

      expect(updatedRanking.username, 'jane_doe');
      expect(
          updatedRanking.profilePicture, 'http://example.com/new_profile.jpg');
      expect(updatedRanking.logCount, 50);
      expect(updatedRanking.id, ranking.id); // unchanged
    });
    test(
      'Should copy with empty values',
      () {
        final updatedRanking = ranking.copyWith();
        expect(updatedRanking, ranking);
      },
    );
    test('toMap converts Ranking to a map', () {
      final map = ranking.toMap();

      expect(map['id'], ranking.id);
      expect(map['username'], ranking.username);
      expect(map['profilePicture'], ranking.profilePicture);
      expect(map['logCount'], ranking.logCount);
    });

    test('fromMap creates Ranking from a map', () {
      final map = {
        'id': 1,
        'username': 'john_doe',
        'profilePicture': 'http://example.com/profile.jpg',
        'logCount': 42,
      };

      final fromMapRanking = Ranking.fromMap(map);

      expect(fromMapRanking, ranking);
    });

    test('toJson converts Ranking to JSON string', () {
      final json = ranking.toJson();

      expect(json,
          '{"id":1,"username":"john_doe","profilePicture":"http://example.com/profile.jpg","logCount":42}');
    });

    test('fromJson creates Ranking from JSON string', () {
      final json =
          '{"id":1,"username":"john_doe","profilePicture":"http://example.com/profile.jpg","logCount":42}';

      final fromJsonRanking = Ranking.fromJson(json);

      expect(fromJsonRanking, ranking);
    });

    test('toString returns correct string representation', () {
      final string = ranking.toString();

      expect(string,
          'Ranking(id: 1, username: john_doe, profilePicture: http://example.com/profile.jpg, logCount: 42)');
    });

    test('equality operator returns true for identical objects', () {
      final identicalRanking = Ranking(
        id: 1,
        username: 'john_doe',
        profilePicture: 'http://example.com/profile.jpg',
        logCount: 42,
      );

      expect(ranking == identicalRanking, true);
    });

    test('hashCode returns correct hash code', () {
      final hashCode = ranking.hashCode;

      expect(
          hashCode,
          ranking.id.hashCode ^
              ranking.username.hashCode ^
              ranking.profilePicture.hashCode ^
              ranking.logCount.hashCode);
    });
  });
}
