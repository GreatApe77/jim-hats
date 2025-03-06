part of 'user_stats_cubit.dart';

sealed class UserStatsState {}

final class UserStatsInitial extends UserStatsState {}

final class UserStatsDataLoadInProgess extends UserStatsState {}

final class UsersStatsDataSuccess extends UserStatsState {
  final LoggedUser loggedUser;

  final List<ExerciseLog> logsOfUser;
  UsersStatsDataSuccess({required this.loggedUser, required this.logsOfUser});
}
