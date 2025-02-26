import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:meta/meta.dart';

part 'user_stats_state.dart';

class UserStatsCubit extends Cubit<UserStatsState> {
  final LoggedUserRepository _loggedUserRepository;
  final ExerciseLogsRepository _exerciseLogsRepository;
  UserStatsCubit({
    required LoggedUserRepository loggedUserRepository,
    required ExerciseLogsRepository exerciseLogRepository,
  })  : _exerciseLogsRepository = exerciseLogRepository,
        _loggedUserRepository = loggedUserRepository,
        super(UserStatsInitial());

  void loadUserStatsData() async {
    emit(UserStatsDataLoadInProgess());
    final loggedUser = await _loggedUserRepository.getLoggedUser();
    emit(UsersStatsDataSuccess(loggedUser: loggedUser));
  }
}
