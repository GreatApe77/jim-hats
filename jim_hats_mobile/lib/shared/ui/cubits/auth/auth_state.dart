part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

final class AuthState {
  final AuthStatus authStatus;
  final LoggedUser? user;
  AuthState({required this.authStatus, this.user});

  AuthState copyWith(
      {AuthStatus? authStatus, Nullable<LoggedUser>? loggedUser}) {
    return AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: loggedUser != null ? loggedUser.value : user);
  }
}
