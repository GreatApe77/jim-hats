// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginDto {
  final String username;
  final String password;

  LoginDto({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory LoginDto.fromMap(Map<String, dynamic> map) {
    return LoginDto(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginDto.fromJson(String source) => LoginDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
