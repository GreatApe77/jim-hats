part of 'edit_check_in_page_cubit.dart';

enum EditCheckInPageStatus { idle, loading, success, error }

final class EditCheckInPageState {
  final String title;
  final String? description;
  final XFile? image;
  final String imageUrl;
  final String errorMessage;

  final EditCheckInPageStatus status;

  EditCheckInPageState({
    required this.imageUrl,
    required this.errorMessage,
    required this.title,
    this.description,
    this.image,
    required this.status,
  });

  EditCheckInPageState copyWith({
    String? title,
    Nullable<String>? description,
    Nullable<XFile>? image,
    EditCheckInPageStatus? status,
    String? errorMessage,
    String? imageUrl
  }) {
    return EditCheckInPageState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description != null ? description.value : this.description,
      image: image != null ? image.value : this.image,
      imageUrl: imageUrl??this.imageUrl
    );
  }
}
