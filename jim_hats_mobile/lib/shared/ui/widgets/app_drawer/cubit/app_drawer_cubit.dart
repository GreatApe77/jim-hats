import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:meta/meta.dart';

part 'app_drawer_state.dart';

class AppDrawerCubit extends Cubit<AppDrawerState> {
  final LoggedUserRepository _loggedUserRepository;
  final GymChallengesRepository _gymChallengesRepository;
  AppDrawerCubit(
      {required LoggedUserRepository loggedUserRepository,
      required GymChallengesRepository gymChallengesRepository})
      : _loggedUserRepository = loggedUserRepository,
        _gymChallengesRepository = gymChallengesRepository,
        super(AppDrawerInitial());

  void loadDrawerData() async {
    emit(AppDrawerLoadDataInProgress());
    //final user = await _loggedUserRepository.getLoggedUser();
    //emit(AppDrawerLoadUserSuccess(loggedUser: user));
    final data = await Future.wait([
      _loggedUserRepository.getLoggedUser(),
      _gymChallengesRepository.getGymChallengesOfUser(2)
    ]);
    emit(AppDrawerLoadDataSuccess(
        loggedUser: data[0] as LoggedUser,
        challenges: data[1] as List<GymChallenge>));
  }
}
