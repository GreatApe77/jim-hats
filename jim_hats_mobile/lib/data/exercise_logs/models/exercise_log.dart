// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExerciseLog {
  final int id;
  final String title;
  final String? description;
  final String? image;
  final DateTime date;
  final int userId;
  final int gymChallengeId;
  ExerciseLog({
    required this.id,
    required this.title,
    this.description,
    this.image,
    required this.date,
    required this.userId,
    required this.gymChallengeId,
  });

  ExerciseLog copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    DateTime? date,
    int? userId,
    int? gymChallengeId,
  }) {
    return ExerciseLog(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      gymChallengeId: gymChallengeId ?? this.gymChallengeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
      'gymChallengeId': gymChallengeId,
    };
  }

  factory ExerciseLog.fromMap(Map<String, dynamic> map) {
    return ExerciseLog(
      id: map['id'] as int,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      userId: map['userId'] as int,
      gymChallengeId: map['gymChallengeId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseLog.fromJson(String source) =>
      ExerciseLog.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExerciseLog(id: $id, title: $title, description: $description, image: $image, date: $date, userId: $userId, gymChallengeId: $gymChallengeId)';
  }

  @override
  bool operator ==(covariant ExerciseLog other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.image == image &&
        other.date == date &&
        other.userId == userId &&
        other.gymChallengeId == gymChallengeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        image.hashCode ^
        date.hashCode ^
        userId.hashCode ^
        gymChallengeId.hashCode;
  }
}

// model ExerciseLog {
//   id             Int          @id @default(autoincrement())
//   title          String       @db.VarChar(255)
//   description    String?
//   image          String?
//   date           DateTime
//   user           User         @relation(fields: [userId], references: [id])
//   gymChallenge   GymChallenge @relation(fields: [gymChallengeId], references: [id])
//   userId         Int          @map("user_id")
//   gymChallengeId Int          @map("gym_challenge_id")

//   @@map("exercise_logs")
// }
