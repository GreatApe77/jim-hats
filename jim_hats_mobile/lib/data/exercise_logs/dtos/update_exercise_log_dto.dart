// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateExerciseLogDto {
  final String? title;
  final String? description;
  final String? image;

  UpdateExerciseLogDto({
    this.title,
    this.description,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image': image,
    };
  }

  String toJson() => json.encode(toMap());
}
