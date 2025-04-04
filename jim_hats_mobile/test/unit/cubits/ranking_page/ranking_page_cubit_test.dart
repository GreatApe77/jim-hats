import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/ranking_page/ranking_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'ranking_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LoggedUserRepository>(),
  MockSpec<GymChallengesRepository>(),
])
void main() {
  late RankingPageCubit sut;
  late MockLoggedUserRepository mockLoggedUserRepository;
  late MockGymChallengesRepository mockGymChallengesRepository;
  const sampleChallengeId = 9;
  final sampleLoggedUser =
      LoggedUser(id: 4, username: 'username', email: 'email');
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
      sut = RankingPageCubit(
        gymChallengesRepository: mockGymChallengesRepository,
        loggedUserRepository: mockLoggedUserRepository,
      );
    },
  );

  test(
    'Should count total of logs of Ranking list',
    () {
      final sampleRankings = [
        Ranking(
          id: 1,
          username: 'username',
          logCount: 100,
        ),
        Ranking(
          id: 2,
          username: 'username2',
          logCount: 101,
        )
      ];
      final result = sut.countTotalOfLogs(sampleRankings);
      expect(result, 201);
    },
  );
  test(
    'Should start with empty inital state',
    () {
      expect(sut.state, isA<RankingPageInitial>());
    },
  );
  blocTest<RankingPageCubit, RankingPageState>(
    'Should load ranking page data',
    setUp: () {
      when(
        mockLoggedUserRepository.getLoggedUser(),
      ).thenAnswer(
        (_) async => sampleLoggedUser,
      );
      when(
        mockGymChallengesRepository.getGymChallengesOfUser(any),
      ).thenAnswer(
        (_) async => sampleChallenges,
      );
    },
    build: () => sut,
    act: (cubit) => cubit.loadData(sampleChallengeId),
    expect: () => [
      isA<RankingPageDataLoadInProgress>(),
      isA<RankingPagedDataLoadSuccess>()
    ],
  );
}
