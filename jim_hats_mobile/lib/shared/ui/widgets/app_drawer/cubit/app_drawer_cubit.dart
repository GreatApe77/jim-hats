import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:meta/meta.dart';

part 'app_drawer_state.dart';

class AppDrawerCubit extends Cubit<AppDrawerState> {
  final LoggedUserRepository _loggedUserRepository;
  AppDrawerCubit({required LoggedUserRepository loggedUserRepository})
      : _loggedUserRepository = loggedUserRepository,
        super(AppDrawerInitial());

  void loadLoggedUser() async {
    emit(AppDrawerLoadUserInProgress());
    final user = await _loggedUserRepository.getLoggedUser();
    emit(AppDrawerLoadUserSuccess(loggedUser: user));
  }
}
