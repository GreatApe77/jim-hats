import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';

void main() {
  group('LoggedUser', () {
    final loggedUser = LoggedUser(
      id: 1,
      username: 'john_doe',
      email: 'john_doe@example.com',
      profilePicture: 'http://example.com/profile.jpg',
    );

    test('copyWith creates a new instance with updated values', () {
      final updatedLoggedUser = loggedUser.copyWith(
        username: 'jane_doe',
        email: 'jane_doe@example.com',
        profilePicture: 'http://example.com/new_profile.jpg',
      );

      expect(updatedLoggedUser.username, 'jane_doe');
      expect(updatedLoggedUser.email, 'jane_doe@example.com');
      expect(updatedLoggedUser.profilePicture, 'http://example.com/new_profile.jpg');
      expect(updatedLoggedUser.id, loggedUser.id); // unchanged
    });

    test('toMap converts LoggedUser to a map', () {
      final map = loggedUser.toMap();

      expect(map['id'], loggedUser.id);
      expect(map['username'], loggedUser.username);
      expect(map['email'], loggedUser.email);
      expect(map['profilePicture'], loggedUser.profilePicture);
    });

    test('fromMap creates LoggedUser from a map', () {
      final map = {
        'id': 1,
        'username': 'john_doe',
        'email': 'john_doe@example.com',
        'profilePicture': 'http://example.com/profile.jpg',
      };

      final fromMapLoggedUser = LoggedUser.fromMap(map);

      expect(fromMapLoggedUser, loggedUser);
    });

    test('toJson converts LoggedUser to JSON string', () {
      final json = loggedUser.toJson();

      expect(json, '{"id":1,"username":"john_doe","email":"john_doe@example.com","profilePicture":"http://example.com/profile.jpg"}');
    });

    test('fromJson creates LoggedUser from JSON string', () {
      final json = '{"id":1,"username":"john_doe","email":"john_doe@example.com","profilePicture":"http://example.com/profile.jpg"}';

      final fromJsonLoggedUser = LoggedUser.fromJson(json);

      expect(fromJsonLoggedUser, loggedUser);
    });

    test('toString returns correct string representation', () {
      final string = loggedUser.toString();

      expect(string, 'LoggedUser(id: 1, username: john_doe, email: john_doe@example.com, profilePicture: http://example.com/profile.jpg)');
    });

    test('equality operator returns true for identical objects', () {
      final identicalLoggedUser = LoggedUser(
        id: 1,
        username: 'john_doe',
        email: 'john_doe@example.com',
        profilePicture: 'http://example.com/profile.jpg',
      );

      expect(loggedUser == identicalLoggedUser, true);
    });

    test('hashCode returns correct hash code', () {
      final hashCode = loggedUser.hashCode;

      expect(hashCode, loggedUser.id.hashCode ^
          loggedUser.username.hashCode ^
          loggedUser.email.hashCode ^
          loggedUser.profilePicture.hashCode);
    });
  });
}