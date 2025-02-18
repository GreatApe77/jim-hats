part of 'create_account_page_cubit.dart';

 class CreateAccountPageState {
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
  CreateAccountPageState copyWith(
      {String? username,
      String? email,
      String? password,
      String? confirmPassword,
      Nullable<XFile>? image}) {
    return CreateAccountPageState(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        image: image!=null?image.value:this.image);
  }
}

