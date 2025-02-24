part of 'check_in_page_cubit.dart';

enum NewCheckInPageStatus { success, loading, failed, idle }

final class NewCheckInPageState {
  final XFile? photo;
  final String title;
  final String description;
  final NewCheckInPageStatus status;
  NewCheckInPageState(
      {required this.status,
      required this.photo,
      required this.title,
      required this.description});

  NewCheckInPageState copyWith(
      {Nullable<XFile>? photo,
      String? title,
      String? description,
      NewCheckInPageStatus? status}) {
    return NewCheckInPageState(
        status: status ?? this.status,
        photo: photo != null ? photo.value : this.photo,
        title: title ?? this.title,
        description: description ?? this.description);
  }
}
