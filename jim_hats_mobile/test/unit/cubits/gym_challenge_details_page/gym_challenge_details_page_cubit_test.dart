import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_details_page/gym_challenge_details_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_page/gym_challenge_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'gym_challenge_details_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GymChallengesRepository>(),
  MockSpec<LoggedUserRepository>(),
])
void main() {
  late GymChallengeDetailsPageCubit sut;
  late MockGymChallengesRepository mockGymChallengesRepository;
  late MockLoggedUserRepository mockLoggedUserRepository;

  const sampleChallengeId = 2;
  final sampleLoggedUser = LoggedUser(id: 2, username: '', email: '');
  final sampleMembers = [
    ChallengeMember(id: sampleLoggedUser.id, username: 'LEADER'),
    ChallengeMember(id: 99, username: 'MEMBER'),
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
      mockLoggedUserRepository = MockLoggedUserRepository();
      mockGymChallengesRepository = MockGymChallengesRepository();
      sut = GymChallengeDetailsPageCubit(
        gymChallengesRepository: mockGymChallengesRepository,
        loggedUserRepository: mockLoggedUserRepository,
      );
    },
  );
  test(
    'Should have empty initial state',
    () {
      expect(sut.state, isA<GymChallengeDetailsPageInitial>());
    },
  );
  blocTest<GymChallengeDetailsPageCubit, GymChallengeDetailsPageState>(
    'Should load details page data',
    setUp: () {
      when(mockLoggedUserRepository.getLoggedUser()).thenAnswer(
        (_) async => sampleLoggedUser,
      );
      when(
        mockGymChallengesRepository.getMembersOfChallenge(sampleChallengeId),
      ).thenAnswer(
        (_) async => sampleMembers,
      );
      when(
        mockGymChallengesRepository.getGymChallengesOfUser(sampleLoggedUser.id),
      ).thenAnswer(
        (_) async => sampleChallenges,
      );
    },
    build: () => sut,
    act: (cubit) => cubit.loadData(sampleChallengeId),
    expect: () => [
      isA<GymChallengeDetailsPageLoadDataInProgress>(),
      isA<GymChallengeDetailsPageLoadSuccess>()
          .having(
            (state) => state.challenge.name,
            'Current challenge',
            'name2',
          )
          .having(
            (state) => state.admin.username,
            'Leader',
            'LEADER',
          )
          .having(
            (state) => state.members,
            'Members list',
            isA<List<ChallengeMember>>(),
          ),
    ],
  );
  blocTest<GymChallengeDetailsPageCubit, GymChallengeDetailsPageState>(
    'Should handle exception while loading page data',
    setUp: () {
      when(mockLoggedUserRepository.getLoggedUser()).thenThrow(Error());
    },
    build: () => sut,
    act: (cubit) => cubit.loadData(sampleChallengeId),
    expect: () => [
      isA<GymChallengeDetailsPageLoadDataInProgress>(),
      isA<GymChallengeDetailsPageLoadError>(),
    ],
  );
}
