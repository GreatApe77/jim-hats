// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateLoggedUserDto {
  final String? profilePicture;

  UpdateLoggedUserDto({
    required this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profilePicture': profilePicture,
    };
  }

  String toJson() => json.encode(toMap());
}
