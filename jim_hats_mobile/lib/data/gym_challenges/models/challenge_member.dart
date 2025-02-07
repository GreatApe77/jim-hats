// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChallengeMember {
  final int id;
  final String username;
  final String? profilePicture;
  ChallengeMember({
    required this.id,
    required this.username,
    this.profilePicture,
  });
  

  ChallengeMember copyWith({
    int? id,
    String? username,
    String? profilePicture,
  }) {
    return ChallengeMember(
      id: id ?? this.id,
      username: username ?? this.username,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'profilePicture': profilePicture,
    };
  }

  factory ChallengeMember.fromMap(Map<String, dynamic> map) {
    return ChallengeMember(
      id: map['id'] as int,
      username: map['username'] as String,
      profilePicture: map['profilePicture'] != null ? map['profilePicture'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChallengeMember.fromJson(String source) => ChallengeMember.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChallengeMember(id: $id, username: $username, profilePicture: $profilePicture)';

  @override
  bool operator ==(covariant ChallengeMember other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.username == username &&
      other.profilePicture == profilePicture;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ profilePicture.hashCode;
}
