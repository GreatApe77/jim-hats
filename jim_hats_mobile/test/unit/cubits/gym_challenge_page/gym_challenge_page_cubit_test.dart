import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_page/gym_challenge_page_cubit.dart';
import 'package:mockito/annotations.dart';

import 'gym_challenge_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ExerciseLogsRepository>(),
  MockSpec<GymChallengesRepository>(),
  MockSpec<LoggedUserRepository>()
])
void main() {
  late GymChallengePageCubit sut;
  late MockGymChallengesRepository mockGymChallengesRepository;
  late MockLoggedUserRepository mockLoggedUserRepository;
  late MockExerciseLogsRepository mockExerciseLogsRepository;
  setUp(
    () {
      mockGymChallengesRepository = MockGymChallengesRepository();
      mockLoggedUserRepository = MockLoggedUserRepository();
      mockExerciseLogsRepository = MockExerciseLogsRepository();
      
    },
  );
}
