// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GymChallenge {
  final int id;
  final String name;
  final String description;
  final String? image;
  final String? joinId;
  final DateTime createdAt;
  final DateTime startAt;
  final DateTime endAt;
  final int creatorId;
  GymChallenge({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    this.joinId,
    required this.createdAt,
    required this.startAt,
    required this.endAt,
    required this.creatorId,
  });

  GymChallenge copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    String? joinId,
    DateTime? createdAt,
    DateTime? startAt,
    DateTime? endAt,
    int? creatorId,
  }) {
    return GymChallenge(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      joinId: joinId ?? this.joinId,
      createdAt: createdAt ?? this.createdAt,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      creatorId: creatorId ?? this.creatorId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'joinId': joinId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'startAt': startAt.millisecondsSinceEpoch,
      'endAt': endAt.millisecondsSinceEpoch,
      'creatorId': creatorId,
    };
  }

  factory GymChallenge.fromMap(Map<String, dynamic> map) {
    return GymChallenge(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      joinId: map['joinId'] != null ? map['joinId'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      startAt: DateTime.fromMillisecondsSinceEpoch(map['startAt'] as int),
      endAt: DateTime.fromMillisecondsSinceEpoch(map['endAt'] as int),
      creatorId: map['creatorId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GymChallenge.fromJson(String source) => GymChallenge.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GymChallenge(id: $id, name: $name, description: $description, image: $image, joinId: $joinId, createdAt: $createdAt, startAt: $startAt, endAt: $endAt, creatorId: $creatorId)';
  }

  @override
  bool operator ==(covariant GymChallenge other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.image == image &&
      other.joinId == joinId &&
      other.createdAt == createdAt &&
      other.startAt == startAt &&
      other.endAt == endAt &&
      other.creatorId == creatorId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      image.hashCode ^
      joinId.hashCode ^
      createdAt.hashCode ^
      startAt.hashCode ^
      endAt.hashCode ^
      creatorId.hashCode;
  }
}

// model GymChallenge {
//   id          Int           @id @default(autoincrement())
//   name        String        @db.VarChar(255)
//   description String
//   image       String?
//   joinId      String?       @unique @default(uuid()) @db.VarChar(255)
//   createdAt   DateTime      @default(now()) @map("created_at")
//   startAt     DateTime      @map("start_at")
//   endAt       DateTime      @map("end_at")
//   creatorId   Int           @map("creator_id")
//   members     User[]
//   logs        ExerciseLog[]

//   @@map("gym_challenges")
// }
