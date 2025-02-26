class AddExerciseLogToChallengeDto {
  final String title;
  final String description;

  ///Optional image url
  final String? image;

  AddExerciseLogToChallengeDto(
      {required this.title, required this.description, required this.image});
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
    };
  }
}
