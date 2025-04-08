import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:meta/meta.dart';

part 'ranking_page_state.dart';

class RankingPageCubit extends Cubit<RankingPageState> {
  final GymChallengesRepository _gymChallengesRepository;
  final LoggedUserRepository _loggedUserRepository;
  RankingPageCubit({
    required GymChallengesRepository gymChallengesRepository,
    required LoggedUserRepository loggedUserRepository,
  })  : _loggedUserRepository = loggedUserRepository,
        _gymChallengesRepository = gymChallengesRepository,
        super(
          RankingPageInitial(),
        );

  Future<void> loadData(int challengeId) async {
    emit(RankingPageDataLoadInProgress());

    final loggedUser = await _loggedUserRepository.getLoggedUser();
    final data = await Future.wait([
      _gymChallengesRepository.getRankingsOfChallenge(challengeId),
      _gymChallengesRepository.getGymChallengesOfUser(loggedUser.id),
    ]);

    final rankings = data[0] as List<Ranking>;
    final challenges = data[1] as List<GymChallenge>;

    final currentChallenge = challenges.firstWhere(
      (challenge) => challenge.id == challengeId,
    );

    emit(
      RankingPagedDataLoadSuccess(
        rankings: rankings,
        challenge: currentChallenge,
      ),
    );
  }

  //double getAverageOfWorkoutsPerDay(Map<String,Ranking> rankingsGroupedByDay){
  //int[] averageOfDay;
  //}

  int countTotalOfLogs(List<Ranking> rankings) {
    int total = 0;
    for (var ranking in rankings) {
      total += ranking.logCount;
    }

    return total;
  }
}
