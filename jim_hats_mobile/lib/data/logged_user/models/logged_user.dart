// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoggedUser {
  int id;
  String username;
  String email;
  String? profilePicture;
  LoggedUser({
    required this.id,
    required this.username,
    required this.email,
    this.profilePicture,
  });

  LoggedUser copyWith({
    int? id,
    String? username,
    String? email,
    String? profilePicture,
  }) {
    return LoggedUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
    };
  }

  factory LoggedUser.fromMap(Map<String, dynamic> map) {
    return LoggedUser(
      id: map['id'] as int,
      username: map['username'] as String,
      email: map['email'] as String,
      profilePicture: map['profilePicture'] != null ? map['profilePicture'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoggedUser.fromJson(String source) =>
      LoggedUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoggedUser(id: $id, username: $username, email: $email, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(covariant LoggedUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.username == username &&
      other.email == email &&
      other.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      email.hashCode ^
      profilePicture.hashCode;
  }
}
