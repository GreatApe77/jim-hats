import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/cache_service.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/create_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/update_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'gym_challenges_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GymChallengeDataSource>(),
  MockSpec<CacheService>(),
])
void main() {
  late GymChallengesRepository sut;
  late CacheService mockCacheService;
  late GymChallengeDataSource mockGymChallengeDataSource;
  final sampleChallengeId = 5;
  final sampleUserId = 4;
  final sampleJoinId = '19048e81-ef1b-4739-9391-870fe7dcaf58';
  final sampleUpdateGymChallengeDto =
      UpdateGymChallengeDto(name: 'UpdatedName');
  final sampleCreateChallengeDto = CreateGymChallengeDto(
      startAt: '20/03/2025',
      endAt: '20/03/2026',
      name: 'name',
      description: 'description');
  final sampleListOfRankings = [
    Ranking(
      id: 7,
      username: 'username',
      logCount: 99,
    )
  ];
  final sampleChallengeMembersList = [
    ChallengeMember(
      id: 4,
      username: 'username',
      profilePicture: 'profilePicture',
    )
  ];
  final sampleListOfGymChallenges = [
    GymChallenge(
      id: 1,
      name: 'name',
      description: 'description',
      createdAt: DateTime(2025),
      startAt: DateTime(2025),
      endAt: DateTime(2025),
      creatorId: sampleUserId,
    ),
    GymChallenge(
      id: 2,
      name: 'name2',
      description: 'description2',
      createdAt: DateTime(2025),
      startAt: DateTime(2025),
      endAt: DateTime(2025),
      creatorId: sampleUserId,
    ),
  ];
  setUp(
    () {
      mockCacheService = MockCacheService();
      mockGymChallengeDataSource = MockGymChallengeDataSource();
      sut = GymChallengesRepository(
        gymChallengeDataSource: mockGymChallengeDataSource,
        cacheService: mockCacheService,
      );
    },
  );

  group(
    'Get gym challenges of user',
    () {
      test(
        'Should get gym challenges of user (cache hit)',
        () async {
          when(
            mockCacheService.get<List<GymChallenge>>('challenges'),
          ).thenReturn(sampleListOfGymChallenges);
          final result = await sut.getGymChallengesOfUser(sampleUserId);
          expect(result, isA<List<GymChallenge>>());
          expect(result.length, 2);
          expect(result[1].name, 'name2');
        },
      );
      test(
        'Should get gym challenges of user (cache miss)',
        () async {
          when(
            mockCacheService.get<List<GymChallenge>>('challenges'),
          ).thenReturn(null);
          when(
            mockGymChallengeDataSource.getGymChallengesOfUser(sampleUserId),
          ).thenAnswer(
            (_) async => sampleListOfGymChallenges,
          );
          final result = await sut.getGymChallengesOfUser(sampleUserId);
          expect(result, isA<List<GymChallenge>>());
          expect(result.length, 2);
          expect(result[1].name, 'name2');
        },
      );
    },
  );
  group(
    'Get rankings of challenge',
    () {
      test(
        'Should get the rankings of a challenge (cache hit)',
        () async {
          when(
            mockCacheService.get<List<Ranking>>('ranking-$sampleChallengeId'),
          ).thenReturn(sampleListOfRankings);
          final result = await sut.getRankingsOfChallenge(sampleChallengeId);
          expect(result, isA<List<Ranking>>());
          expect(result.length, 1);
          expect(result[0].logCount, 99);
        },
      );
      test(
        'Should get the rankings of a challenge (cache miss)',
        () async {
          when(
            mockCacheService.get<List<Ranking>>('ranking-$sampleChallengeId'),
          ).thenReturn(null);
          when(
            mockGymChallengeDataSource.getRankingOfChallenge(sampleChallengeId),
          ).thenAnswer(
            (_) async => sampleListOfRankings,
          );
          final result = await sut.getRankingsOfChallenge(sampleChallengeId);
          expect(result, isA<List<Ranking>>());
          expect(result.length, 1);
          expect(result[0].logCount, 99);
        },
      );
    },
  );
  group(
    'Get members of challenge',
    () {
      test(
        'Should get the member of a challenge (cache hit)',
        () async {
          when(
            mockCacheService
                .get<List<ChallengeMember>>('members-$sampleChallengeId'),
          ).thenReturn(sampleChallengeMembersList);
          final result = await sut.getMembersOfChallenge(sampleChallengeId);
          expect(result, isA<List<ChallengeMember>>());
          expect(result.length, 1);
          expect(result[0].username, 'username');
        },
      );
      test(
        'Should get the members of a challenge (cache miss)',
        () async {
          when(
            mockCacheService
                .get<List<ChallengeMember>>('members-$sampleChallengeId'),
          ).thenReturn(null);
          when(
            mockGymChallengeDataSource.getMembersOfChallenge(sampleChallengeId),
          ).thenAnswer(
            (_) async => sampleChallengeMembersList,
          );
          final result = await sut.getMembersOfChallenge(sampleChallengeId);
          expect(result, isA<List<ChallengeMember>>());
          expect(result.length, 1);
          expect(result[0].username, 'username');
        },
      );
    },
  );
  group(
    'Create Gym Challenge',
    () {
      test(
        'Should create a gym challenge clearing the cache',
        () async {
          await expectLater(
              sut.createGymChallenge(sampleCreateChallengeDto), completes);
          verifyInOrder([
            mockGymChallengeDataSource
                .createGymChallenge(sampleCreateChallengeDto),
            mockCacheService.remove('challenges')
          ]);
        },
      );
    },
  );
  group(
    'Join Gym Challenge',
    () {
      test(
        'Should join a gym challenge clearing the cache',
        () async {
          await expectLater(sut.joinChallenge(sampleJoinId), completes);
          verifyInOrder([
            mockGymChallengeDataSource.joinChallenge(sampleJoinId),
            mockCacheService.remove('challenges')
          ]);
        },
      );
    },
  );
  group(
    'Update Gym Challenge',
    () {
      test(
        'Should update a gym challenge clearing the cache',
        () async {
          await expectLater(
              sut.updateGymChallenge(
                  sampleChallengeId, sampleUpdateGymChallengeDto),
              completes);
          verifyInOrder([
            mockGymChallengeDataSource.updateChallenge(
              sampleChallengeId,
              sampleUpdateGymChallengeDto,
            )
          ]);
        },
      );
    },
  );
}
