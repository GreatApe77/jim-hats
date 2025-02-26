part of 'app_drawer_cubit.dart';

@immutable
sealed class AppDrawerState {
  //final List<dynamic> challenges = [];

  const AppDrawerState();
}

final class AppDrawerInitial extends AppDrawerState {
  const AppDrawerInitial();
}

final class AppDrawerLoadDataInProgress extends AppDrawerState {
  const AppDrawerLoadDataInProgress();
}

final class AppDrawerLoadDataSuccess extends AppDrawerState {
  final LoggedUser loggedUser;
  final List<GymChallenge> challenges;
  const AppDrawerLoadDataSuccess(
      {required this.loggedUser, required this.challenges});
}
