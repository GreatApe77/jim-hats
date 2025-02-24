part of 'home_page_cubit.dart';

sealed class HomePageState {}

final class HomePageDataInitial extends HomePageState {}

final class HomePageDataLoading extends HomePageState {}

final class HomePageDataSuccess extends HomePageState {
  final LoggedUser loggedUser;

  HomePageDataSuccess({required this.loggedUser});
}

final class HomePageDataError extends HomePageState {}
