import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final LoggedUserRepository _loggedUserRepository;
  HomePageCubit({required LoggedUserRepository loggedUserRepository})
      : _loggedUserRepository = loggedUserRepository,
        super(HomePageDataInitial());

  void loadData() async {
    try {
      emit(HomePageDataLoading());
      final loggedUser = await _loggedUserRepository.getLoggedUser();
      emit(HomePageDataSuccess(loggedUser: loggedUser));
    } catch (e) {
      emit(HomePageDataError());
    }
  }
}
