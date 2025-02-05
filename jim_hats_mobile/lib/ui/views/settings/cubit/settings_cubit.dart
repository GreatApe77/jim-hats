import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final LoggedUserRepository _loggedUserRepository;
  SettingsCubit({required LoggedUserRepository loggedUserRepository})
      : _loggedUserRepository = loggedUserRepository,
        super(SettingsInitial());

  
  void loadSettingsData() async {
    emit(SettingsDataLoadInProgress());
    final loggedUser = await _loggedUserRepository.getLoggedUser();
    emit(SettingsDataLoadSuccess(loggedUser: loggedUser));
  }
}
