part of 'sign_in_page_bloc.dart';

enum SignInPageStatus { writingForm, success, failure, loading }

final class SignInPageState {
  final String username;
  final String password;
  final SignInPageStatus status;

  SignInPageState(
      {required this.username, required this.status, required this.password});

  SignInPageState copywith(
      {String? username, String? password, SignInPageStatus? status}) {
    return SignInPageState(
        username: username ?? this.username,
        password: password ?? this.password,
        status: status ?? this.status);
  }

  factory SignInPageState.empty() {
    return SignInPageState(
        username: '', status: SignInPageStatus.writingForm, password: '');
  }
}
