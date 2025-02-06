import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:meta/meta.dart';

part 'gym_challenge_page_state.dart';

class GymChallengePageCubit extends Cubit<GymChallengePageState> {
  final ExerciseLogsRepository _exerciseLogsRepository;
  GymChallengePageCubit(
    {
      required ExerciseLogsRepository exerciseLogsRepository
    }
  ) :
    _exerciseLogsRepository=exerciseLogsRepository,
   super(GymChallengePageInitial());

  void loadLogs(int challengeId) async{
    emit(GymChallengePageDataLoadInProgress());
    final logs = await _exerciseLogsRepository.getLogsOfChallenge(challengeId);
    emit(GymChallengePageDataSuccess(logs: logs));
  }
}
