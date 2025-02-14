part of 'create_account_page_cubit.dart';

@immutable
sealed class CreateAccountPageState {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final XFile? image;

  const CreateAccountPageState(
      {required this.username,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.image});
}

final class CreateAccountPageInitial extends CreateAccountPageState {
  const CreateAccountPageInitial(
      {required super.username,
      required super.email,
      required super.password,
      required super.confirmPassword,
      required super.image});
}
