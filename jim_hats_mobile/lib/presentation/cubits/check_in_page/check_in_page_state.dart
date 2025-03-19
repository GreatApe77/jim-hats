part of 'check_in_page_cubit.dart';

sealed class CheckInPageState {}

final class CheckInPageInitial extends CheckInPageState {}

final class CheckInPageLoading extends CheckInPageState {}

final class CheckInPageSuccess extends CheckInPageState {}

final class CheckInPageError extends CheckInPageState {
  final String errorMessage;

  CheckInPageError({required this.errorMessage});
}
