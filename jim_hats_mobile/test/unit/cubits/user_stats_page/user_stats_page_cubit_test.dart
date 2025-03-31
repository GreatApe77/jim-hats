import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/user_stats_page/user_stats_cubit.dart';
import 'package:mockito/annotations.dart';

import 'user_stats_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ExerciseLogsRepository>(),
  MockSpec<LoggedUserRepository>(),
])
void main() {
  late UserStatsCubit sut;
  late MockExerciseLogsRepository mockExerciseLogsRepository;
  late MockLoggedUserRepository mockLoggedUserRepository;
  setUp(
    () {
      mockLoggedUserRepository = MockLoggedUserRepository();
      mockExerciseLogsRepository = MockExerciseLogsRepository();
      sut = UserStatsCubit(
        loggedUserRepository: mockLoggedUserRepository,
        exerciseLogRepository: mockExerciseLogsRepository,
      );
    },
  );
  test(
    'Should start with empty initial data',
    () {
      expect(
        sut.state,
        isA<UserStatsInitial>(),
      );
    },
  );
  blocTest<UserStatsCubit, UserStatsState>(
    'Should load user stats page data',
    build: () => sut,
    act: (cubit) => cubit.loadUserStatsData(),
    expect: () => [
      isA<UserStatsDataLoadInProgess>(),
      isA<UsersStatsDataSuccess>()
          .having(
            (state) => state.loggedUser,
            'Logged user',
            isA<LoggedUser>(),
          )
          .having(
            (state) => state.logsOfUser,
            'All logs of the user',
            isA<List<ExerciseLog>>(),
          ),
    ],
  );
}
