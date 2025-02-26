part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

final class AuthState {
  final bool failed;
  final AuthStatus authStatus;
  final LoggedUser? user;
  AuthState({required this.authStatus, this.user, required this.failed});

  AuthState copyWith(
      {AuthStatus? authStatus,
      Nullable<LoggedUser>? loggedUser,
      bool? failed}) {
    return AuthState(
        failed: failed ?? this.failed,
        authStatus: authStatus ?? this.authStatus,
        user: loggedUser != null ? loggedUser.value : user);
  }
}
