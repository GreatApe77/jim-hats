// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterDto {
  final String username;
  final String email;
  final String password;
  final String? profilePicture;

  RegisterDto(
      {required this.username,
      required this.email,
      required this.password,
      required this.profilePicture});

  factory RegisterDto.fromJson(String source) =>
      RegisterDto.fromMap(json.decode(source) as Map<String, dynamic>);

  factory RegisterDto.fromMap(Map<String, dynamic> map) {
    return RegisterDto(
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profilePicture: map['profilePicture'] != null
          ? map['profilePicture'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
    };
  }
}
