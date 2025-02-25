part of 'create_challenge_page_cubit.dart';

enum CreateChallengePageStatus { idle, loading, success, error }

final class CreateChallengePageState {
  final CreateChallengePageStatus status;
  final String name;
  final String description;
  final XFile? image;
  final String errorMessage;
  final DateTime startAt;
  final DateTime endAt;

  CreateChallengePageState({
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.name,
    required this.description,
    this.image,
    required this.errorMessage,
  });

  CreateChallengePageState copyWith({
    CreateChallengePageStatus? status,
    String? name,
    String? description,
    Nullable<XFile>? image,
    String? errorMessage,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return CreateChallengePageState(
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image != null ? image.value : this.image,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
