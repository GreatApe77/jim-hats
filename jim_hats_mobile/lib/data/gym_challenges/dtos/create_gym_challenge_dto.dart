class CreateGymChallengeDto {
  final String name;
  final String description;
  final String? image;
  final String startAt;
  final String endAt;

  CreateGymChallengeDto({
    required this.startAt,
    required this.endAt,
    required this.name,
    required this.description,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'startAt': startAt,
      'endAt': endAt,
    };
  }
}
