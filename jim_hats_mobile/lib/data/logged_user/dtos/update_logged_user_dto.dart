

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
}
