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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
    };
  }
}
