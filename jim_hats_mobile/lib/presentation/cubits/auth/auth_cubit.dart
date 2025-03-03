import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/core/exceptions/invalid_token_exception.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/core/exceptions/token_not_found_exception.dart';
import 'package:jim_hats_mobile/core/utils/nullable.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final LoggedUserRepository _loggedUserRepository;
  AuthCubit(
      {required AuthRepository authRepository,
      required LoggedUserRepository loggedUserRepository})
      : _authRepository = authRepository,
        _loggedUserRepository = loggedUserRepository,
        super(AuthState(authStatus: AuthStatus.unknown, failed: false));

  void checkAuthStatus() async {
    try {
      emit(state.copyWith(authStatus: AuthStatus.unknown));
      bool isLoggedIn = await _authRepository.isLoggedIn();
      //await Future.delayed(Duration(seconds: 1));
      if (!isLoggedIn) {
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
        return;
      }
      final loggedUser = await _loggedUserRepository.getLoggedUser();
      emit(state.copyWith(
          authStatus: AuthStatus.authenticated,
          loggedUser: Nullable(loggedUser)));
    } on TokenNotFoundException {
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    } on InvalidTokenException {
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    } on TimeOutException {
      emit(state.copyWith(failed: true));
    }catch(e){
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    }
  }

  void logOut() async {
    await _authRepository.logout();
    emit(state.copyWith(
        loggedUser: Nullable(null), authStatus: AuthStatus.unauthenticated));
  }
}
