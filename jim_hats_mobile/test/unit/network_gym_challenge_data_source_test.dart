import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/network_gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/create_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/update_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_gym_challenge_data_source_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  late NetworkGymChallengeDataSource sut;
  late HttpService mockHttpClient;
  final int sampleUserId = 3;
  final int sampleChallengeId = 8;
  final String sampleJoinId = '621362bd-5a8a-45b4-a060-b31a24dd1155';
  final CreateGymChallengeDto sampleCreateGymChallengeDto =
      CreateGymChallengeDto(
    startAt: '01/01/2025',
    endAt: '01/01/2026',
    name: 'name',
    description: 'Description here',
  );
  final UpdateGymChallengeDto sampleUpdateGymChallengeDto =
      UpdateGymChallengeDto(name: 'nameUpdated');
  setUp(
    () {
      mockHttpClient = MockHttpService();
      sut = NetworkGymChallengeDataSource(httpClient: mockHttpClient);
    },
  );

  group(
    'Get gym challenges of user',
    () {
      test(
        'Should get gym challenges of a user',
        () async {
          when(mockHttpClient.get('/users/$sampleUserId/gym-challenges'))
              .thenAnswer(
            (_) async => {
              'data': [
                {
                  'id': 2,
                  'name': 'name',
                  'description': 'description',
                  'image': 'image',
                  'joinId': 'code91292',
                  'createdAt': DateTime(2025).millisecondsSinceEpoch,
                  'startAt': DateTime(2025).millisecondsSinceEpoch,
                  'endAt': DateTime(2025).millisecondsSinceEpoch,
                  'creatorId': sampleUserId,
                }
              ]
            },
          );
          final result = await sut.getGymChallengesOfUser(sampleUserId);
          expect(result.length, 1);
          expect(result[0], isA<GymChallenge>());
          expect(result[0].description, 'description');
        },
      );
    },
  );

  group(
    'Get mmembers of challenge',
    () {
      test(
        'Should get members of a challenge',
        () async {
          when(
            mockHttpClient.get(
              '/gym-challenges/$sampleChallengeId/members',
            ),
          ).thenAnswer(
            (_) async => {
              'data': [
                {
                  'id': sampleChallengeId,
                  'username': 'username',
                  'profilePicture': 'profilePicture',
                }
              ]
            },
          );

          final result = await sut.getMembersOfChallenge(sampleChallengeId);
          expect(result.length, 1);
          expect(result[0], isA<ChallengeMember>());
          expect(result[0].username, 'username');
        },
      );
    },
  );

  group(
    'Get ranking of challenge',
    () {
      test(
        'Should get ranking of challenge',
        () async {
          when(mockHttpClient.get('/gym-challenges/$sampleChallengeId/ranking'))
              .thenAnswer(
            (_) async => {
              'data': [
                {
                  'id': 99,
                  'username': 'rankingUsername',
                  'profilePicture': 'profilepicture',
                  'logCount': 50,
                }
              ]
            },
          );

          final result = await sut.getRankingOfChallenge(sampleChallengeId);
          expect(result.length, 1);
          expect(result[0], isA<Ranking>());
          expect(result[0].username, 'rankingUsername');
        },
      );
    },
  );

  group(
    'Create Gym Challenge',
    () {
      test(
        'Should create a Gym Challenge',
        () async {
          when(
            mockHttpClient.post(
              '/gym-challenges',
              data: sampleCreateGymChallengeDto.toMap(),
            ),
          ).thenAnswer(
            (_) async => {},
          );
          await expectLater(
            sut.createGymChallenge(sampleCreateGymChallengeDto),
            completes,
          );
        },
      );
    },
  );
  group(
    'Join Gym Challenge',
    () {
      test(
        'Should join a Gym Challenge',
        () async {
          when(
            mockHttpClient.get(
              '/gym-challenges/$sampleJoinId/join',
            ),
          ).thenAnswer(
            (_) async => {},
          );
          await expectLater(
            sut.joinChallenge(sampleJoinId),
            completes,
          );
        },
      );
    },
  );

  group(
    'Update Gym Challenge',
    () {
      test(
        'Should update gym challenge',
        () async {
          when(
            mockHttpClient.patch(
              '/gym-challenges/$sampleChallengeId',
              data: sampleUpdateGymChallengeDto.toMap(),
            ),
          ).thenAnswer(
            (_) async => {},
          );

          await expectLater(
            sut.updateChallenge(
              sampleChallengeId,
              sampleUpdateGymChallengeDto,
            ),
            completes,
          );
        },
      );
    },
  );

  test(
    'Should throw unimplement method for get challenge by id',
    () async {
      //expect(sut.getGymChallengeById(1),throwsUnimplementedError);
      //  await expectLater(sut.getGymChallengeById(1), throwsUnimplementedError);
      await expectLater(
        () => sut.getGymChallengeById(1),
        throwsA(
          isA<UnimplementedError>(),
        ),
      );
    },
  );
}
