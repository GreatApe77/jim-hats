// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';

class User {
  final String username;
  final String? profilePicture;

  User({
    required this.username,
    this.profilePicture,
  });

  User copyWith({
    String? username,
    String? profilePicture,
  }) {
    return User(
      username: username ?? this.username,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'profilePicture': profilePicture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      profilePicture: map['profilePicture'] != null ? map['profilePicture'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(username: $username, profilePicture: $profilePicture)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.profilePicture == profilePicture;
  }

  @override
  int get hashCode => username.hashCode ^ profilePicture.hashCode;
}

class ExerciseLogWithUser extends ExerciseLog {
  final User user;
  ExerciseLogWithUser(
      {
        required this.user,
        required super.id,
        super.description,
        super.image,
      required super.title,
      required super.date,
      required super.userId,
      required super.gymChallengeId});
  
   @override
     Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
      'gymChallengeId': gymChallengeId,
      'user': user.toMap()
    };
  }
  factory ExerciseLogWithUser.fromMap(Map<String, dynamic> map) {
    print(map['user']);
    return ExerciseLogWithUser(
      user: User.fromMap(map['user']),
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      userId: map['userId'] as int,
      gymChallengeId: map['gymChallengeId'] as int,
    );
  }
  @override
  String toJson() {
    return json.encode(toMap());
  }
  
}
