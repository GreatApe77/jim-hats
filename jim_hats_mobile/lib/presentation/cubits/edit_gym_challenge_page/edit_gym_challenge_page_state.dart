part of 'edit_gym_challenge_page_cubit.dart';

enum EditGymChallengePageStatus { idle, success, loading, error }

final class EditGymChallengePageState {
  final EditGymChallengePageStatus status;
  final String name;
  final String description;
  final String imageUrl;
  final XFile? image;
  final DateTime startAt;
  final DateTime endAt;

  EditGymChallengePageState(
      {required this.status,
      required this.imageUrl,
      required this.name,
      required this.description,
      required this.image,
      required this.startAt,
      required this.endAt});

  EditGymChallengePageState copyWith({
    EditGymChallengePageStatus? status,
    String? name,
    String? description,
    Nullable<XFile>? image,
    String? imageUrl,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return EditGymChallengePageState(
        status: status ?? this.status,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image != null ? image.value : this.image,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
        imageUrl: imageUrl ?? this.imageUrl);
  }
}
