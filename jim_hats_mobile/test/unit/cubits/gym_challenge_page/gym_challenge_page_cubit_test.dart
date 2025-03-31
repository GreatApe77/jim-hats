import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_page/gym_challenge_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
  const sampleChallengeId = 9;
  final sampleLoggedUser = LoggedUser(
    id: 2,
    username: 'LoggedUser',
    email: 'email',
  );
  final sampleRankings = [
    Ranking(id: 1, logCount: 1, username: 'user', profilePicture: ''),
    Ranking(
      id: 2,
      logCount: 200,
      username: sampleLoggedUser.username,
      profilePicture: '',
    )
  ];
  final sampleExerciseLogs = [
    ExerciseLogWithUser(
      user: User(username: 'user', profilePicture: 'profilePicture'),
      id: 1,
      title: 'title',
      date: DateTime(2025, 1, 1),
      userId: 2,
      gymChallengeId: sampleChallengeId,
    ),
    ExerciseLogWithUser(
      user: User(username: 'user2', profilePicture: 'profilePicture2'),
      id: 2,
      title: 'title2',
      date: DateTime(2025, 2, 2),
      userId: sampleLoggedUser.id,
      gymChallengeId: sampleChallengeId,
    )
  ];
  final sampleChallenges = [
    GymChallenge(
      id: 1,
      name: 'name',
      description: 'description',
      createdAt: DateTime(2025),
      startAt: DateTime(2025),
      endAt: DateTime(2025),
      creatorId: 2,
    ),
    GymChallenge(
      id: sampleChallengeId,
      name: 'name2',
      description: 'description2',
      createdAt: DateTime(2025),
      startAt: DateTime(2025),
      endAt: DateTime(2025),
      creatorId: 2,
    )
  ];
  setUp(
    () {
      mockGymChallengesRepository = MockGymChallengesRepository();
      mockLoggedUserRepository = MockLoggedUserRepository();
      mockExerciseLogsRepository = MockExerciseLogsRepository();
      sut = GymChallengePageCubit(
        loggedUserRepository: mockLoggedUserRepository,
        gymChallengesRepository: mockGymChallengesRepository,
        exerciseLogsRepository: mockExerciseLogsRepository,
      );
    },
  );

  test(
    'Should start with empty initial data',
    () {
      expect(sut.state, isA<GymChallengePageInitial>());
    },
  );
  blocTest<GymChallengePageCubit, GymChallengePageState>(
    'Should load data successfully',
    setUp: () {
      when(mockLoggedUserRepository.getLoggedUser()).thenAnswer(
        (_) async => sampleLoggedUser,
      );
      when(
        mockGymChallengesRepository.getGymChallengesOfUser(sampleLoggedUser.id),
      ).thenAnswer((_) async => sampleChallenges);
      when(
        mockGymChallengesRepository.getRankingsOfChallenge(sampleChallengeId),
      ).thenAnswer((_) async => sampleRankings);
      when(
        mockExerciseLogsRepository.getLogsOfChallenge(sampleChallengeId),
      ).thenAnswer((_) async => sampleExerciseLogs);
    },
    build: () => sut,
    act: (cubit) => cubit.loadLogs(sampleChallengeId),
    expect: () => [
      isA<GymChallengePageDataLoadInProgress>(),
      isA<GymChallengePageDataSuccess>()
          .having(
            (state) => state.leader.logCount,
            'Leader',
            sampleRankings[1].logCount,
          )
          .having(
            (state) => state.userRanking.username,
            'User ranking',
            'LoggedUser',
          )
          .having(
            (state) => state.logs,
            'Logs',
            isA<List<ExerciseLogWithUser>>(),
          )
          .having((state) => state.logsGroupedByDate['01/01/2025'],
              'Logs grouped by date', isA<List<ExerciseLogWithUser>>())
          .having(
            (state) => state.challenge.id,
            'Challenge id',
            sampleChallengeId,
          ),
    ],
  );
  blocTest<GymChallengePageCubit, GymChallengePageState>(
    'Should handle unknown exception',
    setUp: () {
      when(mockLoggedUserRepository.getLoggedUser()).thenThrow(Error());
    },
    build: () => sut,
    act: (cubit) => cubit.loadLogs(sampleChallengeId),
    expect: () => [
      isA<GymChallengePageDataLoadInProgress>(),
      isA<GymChallengePageDataLoadFailure>()
    ],
  );
}
