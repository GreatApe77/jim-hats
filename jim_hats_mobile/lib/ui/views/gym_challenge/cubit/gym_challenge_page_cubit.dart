import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:meta/meta.dart';

part 'gym_challenge_page_state.dart';

class GymChallengePageCubit extends Cubit<GymChallengePageState> {
  final ExerciseLogsRepository _exerciseLogsRepository;
  final GymChallengesRepository _gymChallengesRepository;
  final LoggedUserRepository _loggedUserRepository;
  GymChallengePageCubit(
    {
      required LoggedUserRepository loggedUserRepository,      
      required GymChallengesRepository  gymChallengesRepository,
      required ExerciseLogsRepository exerciseLogsRepository
    }
  ) :
    _loggedUserRepository=loggedUserRepository,
    _gymChallengesRepository=gymChallengesRepository,
    _exerciseLogsRepository=exerciseLogsRepository,
   super(GymChallengePageInitial());

  void loadLogs(int challengeId) async{
    emit(GymChallengePageDataLoadInProgress());
    //final data = await _exerciseLogsRepository.getLogsOfChallenge(challengeId);
    final loggedUser = await _loggedUserRepository.getLoggedUser();
    final pageData = await Future.wait([
       _exerciseLogsRepository.getLogsOfChallenge(challengeId),
       _gymChallengesRepository.getGymChallengesOfUser(loggedUser.id)
    ]);
    final challenges = pageData[1] as List<GymChallenge>;
    final currentChallenge = challenges.firstWhere((challenge) =>challenge.id==challengeId ,);
    final logs = pageData[0] as List<ExerciseLogWithUser>;
    // final data = await Future.wait(
    //   _exerciseLogsRepository.getLogsOfChallenge(challengeId),

    // );

    emit(GymChallengePageDataSuccess(logs: logs,challenge: currentChallenge));
  }
}
