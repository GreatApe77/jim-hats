part of 'user_stats_cubit.dart';

@immutable
sealed class UserStatsState {}

final class UserStatsInitial extends UserStatsState {}

final class UserStatsDataLoadInProgess extends UserStatsState{}

final class UsersStatsDataSuccess extends UserStatsState{
  final LoggedUser loggedUser;


  UsersStatsDataSuccess({required this.loggedUser});}