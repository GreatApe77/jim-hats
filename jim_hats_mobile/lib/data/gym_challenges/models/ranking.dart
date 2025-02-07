// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ranking {
  final int id;
  final String username;
  final String? profilePicture;
  final int logCount;
  Ranking({
    required this.id,
    required this.username,
    this.profilePicture,
    required this.logCount,
  });
  

  Ranking copyWith({
    int? id,
    String? username,
    String? profilePicture,
    int? logCount,
  }) {
    return Ranking(
      id: id ?? this.id,
      username: username ?? this.username,
      profilePicture: profilePicture ?? this.profilePicture,
      logCount: logCount ?? this.logCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'profilePicture': profilePicture,
      'logCount': logCount,
    };
  }

  factory Ranking.fromMap(Map<String, dynamic> map) {
    return Ranking(
      id: map['id'] as int,
      username: map['username'] as String,
      profilePicture: map['profilePicture'] != null ? map['profilePicture'] as String : null,
      logCount: map['logCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ranking.fromJson(String source) => Ranking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ranking(id: $id, username: $username, profilePicture: $profilePicture, logCount: $logCount)';
  }

  @override
  bool operator ==(covariant Ranking other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.username == username &&
      other.profilePicture == profilePicture &&
      other.logCount == logCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      profilePicture.hashCode ^
      logCount.hashCode;
  }
}


// export type Ranking ={
//   id: number;
//   username: string;
//   profilePicture: string | null;
//   logCount: number;
// };
