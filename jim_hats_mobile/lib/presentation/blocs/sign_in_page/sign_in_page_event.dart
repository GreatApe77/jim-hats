part of 'sign_in_page_bloc.dart';

sealed class SignInPageEvent {}

final class SignInUsernameChanged extends SignInPageEvent {
  final String username;

  SignInUsernameChanged({required this.username});
}

final class SignInPasswordChanged extends SignInPageEvent {
  final String password;

  SignInPasswordChanged({required this.password});
}

final class SignInFormSubmitted extends SignInPageEvent {}
