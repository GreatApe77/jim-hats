import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';


part 'gym_challenge_page_state.dart';

class GymChallengePageCubit extends Cubit<GymChallengePageState> {
  final ExerciseLogsRepository _exerciseLogsRepository;
  final GymChallengesRepository _gymChallengesRepository;
  final LoggedUserRepository _loggedUserRepository;
  GymChallengePageCubit(
      {required LoggedUserRepository loggedUserRepository,
      required GymChallengesRepository gymChallengesRepository,
      required ExerciseLogsRepository exerciseLogsRepository})
      : _loggedUserRepository = loggedUserRepository,
        _gymChallengesRepository = gymChallengesRepository,
        _exerciseLogsRepository = exerciseLogsRepository,
        super(GymChallengePageInitial());

  void loadLogs(int challengeId) async {
    emit(GymChallengePageDataLoadInProgress());
    //final data = await _exerciseLogsRepository.getLogsOfChallenge(challengeId);
    final loggedUser = await _loggedUserRepository.getLoggedUser();
    final pageData = await Future.wait([
      _exerciseLogsRepository.getLogsOfChallenge(challengeId),
      _gymChallengesRepository.getGymChallengesOfUser(loggedUser.id),
      _gymChallengesRepository.getRankingsOfChallenge(challengeId)
    ]);
    final challenges = pageData[1] as List<GymChallenge>;
    final currentChallenge = challenges.firstWhere(
      (challenge) => challenge.id == challengeId,
    );
    final logs = pageData[0] as List<ExerciseLogWithUser>;
    final rankings = pageData[2] as List<Ranking>;

    // final data = await Future.wait(
    //   _exerciseLogsRepository.getLogsOfChallenge(challengeId),

    // );

    emit(GymChallengePageDataSuccess(
        leader: _getLeader(rankings),
        userRanking: _getUserRanking(rankings, loggedUser),
        logs: logs,
        logsGroupedByDate: _groupLogsByDay(logs),
        challenge: currentChallenge));
  }

  Ranking _getLeader(List<Ranking> rankings) {
    Ranking leader = rankings.first;
    for (var i = 0; i < rankings.length; i++) {
      Ranking current = rankings[i];
      if (current.logCount > leader.logCount) {
        leader = current;
      }
    }
    return leader;
  }
  Map<String,List<ExerciseLogWithUser>> _groupLogsByDay(List<ExerciseLogWithUser> exerciseLogs){
    Map<String,List<ExerciseLogWithUser>> grouped = {};

    for (var exerciseLog in exerciseLogs) {
      final String formatedDateByDay = _formatDateText(exerciseLog.date);
      if(!grouped.containsKey(_formatDateText(exerciseLog.date))){
        grouped[formatedDateByDay] = [];
      }
      grouped[formatedDateByDay]!.add(exerciseLog);
    }
      return grouped;
  }
  Ranking _getUserRanking(List<Ranking> rankings, LoggedUser user) {
    return rankings.firstWhere(
      (element) => element.id == user.id,
    );
  }
  _formatDateText(DateTime date){
    // YYYY/MM/DD
    return '${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}';
  }
}
