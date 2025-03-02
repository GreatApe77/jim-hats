part of 'sign_in_page_bloc.dart';

enum SignInPageStatus { writingForm, success, failure, loading }

final class SignInPageState {
  final String username;
  final String password;
  final String message;
  final SignInPageStatus status;

  SignInPageState({
    required this.username,
    required this.status,
    required this.password,
    required this.message,
  });

  SignInPageState copywith({
    String? username,
    String? password,
    SignInPageStatus? status,
    String? message,
  }) {
    return SignInPageState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  factory SignInPageState.empty() {
    return SignInPageState(
      username: '',
      status: SignInPageStatus.writingForm,
      password: '',
      message: '',
    );
  }
}
