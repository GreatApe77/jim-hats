import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:meta/meta.dart';

part 'gym_challenge_details_page_state.dart';

class GymChallengeDetailsPageCubit extends Cubit<GymChallengeDetailsPageState> {
  final GymChallengesRepository _gymChallengesRepository;
  final LoggedUserRepository _loggedUserRepository;
  GymChallengeDetailsPageCubit(
      {required GymChallengesRepository gymChallengesRepository,
      required LoggedUserRepository loggedUserRepository})
      : _loggedUserRepository = loggedUserRepository,
        _gymChallengesRepository = gymChallengesRepository,
        super(GymChallengeDetailsPageInitial());

  void loadData(int challengeId) async {
    try {
      emit(GymChallengeDetailsPageLoadDataInProgress());
      // ignore: unused_local_variable
      final loggedUser = await _loggedUserRepository.getLoggedUser();
      final data = await Future.wait([
        _gymChallengesRepository.getGymChallengesOfUser(loggedUser.id),
        _gymChallengesRepository.getMembersOfChallenge(challengeId),
      ]);

      final challenges = data[0] as List<GymChallenge>;
      final currentChallenge = challenges.firstWhere(
        (element) => element.id == challengeId,
      );
      final members = data[1] as List<ChallengeMember>;
      print('''



      AGREGOU TUDO

''');
      emit(GymChallengeDetailsPageLoadSuccess(
          members: members,
          admin: _getAdminOfChallenge(currentChallenge, members)));
    } catch (e) {
      emit(GymChallengeDetailsPageLoadError());
    }
  }

  ChallengeMember _getAdminOfChallenge(
      GymChallenge challenge, List<ChallengeMember> members) {
    final creatorId = challenge.creatorId;
    final admin = members.firstWhere(
      (member) => member.id == creatorId,
    );
    return admin;
  }
}
