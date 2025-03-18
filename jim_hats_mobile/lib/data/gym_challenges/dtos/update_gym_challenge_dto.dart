
class UpdateGymChallengeDto {
  final String? name;
  final String? description;
  // DD/MM/YYYY date
  final String? startAt;
  // DD/MM/YYYY date
  final String? endAt;
  final String? image;

  UpdateGymChallengeDto({
    this.name,
    this.description,
    this.startAt,
    this.endAt,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'startAt': startAt,
      'endAt': endAt,
      'image': image,
    };
  }


}
