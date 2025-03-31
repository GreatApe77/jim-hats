part of 'sign_in_page_bloc.dart';

sealed class SignInPageEvent extends Equatable {}

final class SignInUsernameChanged extends SignInPageEvent {
  final String username;

  SignInUsernameChanged({required this.username});
  @override
  List<Object?> get props => [username];
}

final class SignInPasswordChanged extends SignInPageEvent {
  final String password;

  SignInPasswordChanged({required this.password});
  @override
 
  List<Object?> get props => [password];
}

final class SignInFormSubmitted extends SignInPageEvent {
  @override
  
  List<Object?> get props => [];
}
