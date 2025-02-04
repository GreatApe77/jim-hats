part of 'app_drawer_cubit.dart';


@immutable
sealed class AppDrawerState {
  
  final List<dynamic> challenges = [];

  AppDrawerState();
}

final class AppDrawerInitial extends AppDrawerState {
  AppDrawerInitial();

}

final class AppDrawerLoadUserInProgress extends AppDrawerState{
  AppDrawerLoadUserInProgress();
}
final class AppDrawerLoadUserSuccess extends AppDrawerState{
  final LoggedUser loggedUser;
  AppDrawerLoadUserSuccess({
    required this.loggedUser
  });
}