part of 'create_account_page_cubit.dart';

enum Status { writingForm, loading, error, success }

final class CreateAccountPageState {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final XFile? image;
  final Status status;
  final String errorMessage;
  factory CreateAccountPageState.empty() {
    return CreateAccountPageState(
        username: '',
        email: '',
        password: '',
        confirmPassword: '',
        image: null,
        status: Status.writingForm,
        errorMessage: '');
  }
  const CreateAccountPageState(
      {required this.username,
      required this.errorMessage,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.image,
      required this.status});
  CreateAccountPageState copyWith(
      {String? username,
      String? email,
      String? password,
      String? confirmPassword,
      Status? status,
      Nullable<XFile>? image,
      String? errorMessage}) {
    return CreateAccountPageState(
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        image: image != null ? image.value : this.image);
  }
}
