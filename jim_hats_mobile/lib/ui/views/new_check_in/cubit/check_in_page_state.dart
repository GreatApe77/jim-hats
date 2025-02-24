part of 'check_in_page_cubit.dart';

enum CheckInPageStatus { success, loading, failed, idle }

final class CheckInPageState {
  final XFile? photo;
  final String title;
  final String description;
  final CheckInPageStatus status;
  CheckInPageState(
      {required this.status,
      required this.photo,
      required this.title,
      required this.description});

  CheckInPageState copyWith(
      {Nullable<XFile>? photo,
      String? title,
      String? description,
      CheckInPageStatus? status}) {
    return CheckInPageState(
        status: status ?? this.status,
        photo: photo != null ? photo.value : this.photo,
        title: title ?? this.title,
        description: description ?? this.description);
  }
}
