// coverage:ignore-file
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/create_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/update_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';

class MemoryGymChallengeDataSource implements GymChallengeDataSource {
  @override
  Future<GymChallenge> getGymChallengeById(int id) {
    return Future.value(GymChallenge(
        id: 5,
        name: 'Challenge Name',
        description: 'Challenge Description',
        image: null,
        joinId: null,
        createdAt: DateTime.now(),
        startAt: DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch + 20000000),
        endAt: DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch + 80000000),
        creatorId: 1));
  }

  @override
  Future<List<GymChallenge>> getGymChallengesOfUser(int userId) {
    return Future.value([
      GymChallenge(
          id: 5,
          name: 'Challenge 5',
          description: 'Challenge Description 5',
          image: 'https://avatars.githubusercontent.com/u/97452495?s=200&v=4',
          joinId: null,
          createdAt: DateTime.now(),
          startAt: DateTime(2024),
          endAt: DateTime(2027),
          creatorId: 1),
      GymChallenge(
          id: 6,
          name: 'Challenge 6',
          description: 'Challenge Description 6',
          image: 'https://avatars.githubusercontent.com/u/98452395?s=200&v=4',
          joinId: null,
          createdAt: DateTime.now(),
          startAt: DateTime.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch + 20000000),
          endAt: DateTime.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch + 80000000),
          creatorId: 1),
      GymChallenge(
          id: 7,
          name: 'Challenge 7',
          description: 'Challenge Description 7',
          image: null,
          joinId: null,
          createdAt: DateTime.now(),
          startAt: DateTime.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch + 20000000),
          endAt: DateTime.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch + 80000000),
          creatorId: 1)
    ]);
  }

  @override
  Future<List<Ranking>> getRankingOfChallenge(int challengeId) {
    return Future.value([
      Ranking(id: 1, username: 'User1', profilePicture: 'url1', logCount: 10),
      Ranking(id: 2, username: 'User2', profilePicture: 'url2', logCount: 9),
      Ranking(id: 3, username: 'User3', profilePicture: 'url3', logCount: 8),
      Ranking(id: 4, username: 'User4', profilePicture: 'url4', logCount: 7),
      Ranking(id: 5, username: 'User5', profilePicture: 'url5', logCount: 6),
      Ranking(id: 6, username: 'User6', profilePicture: 'url6', logCount: 5),
      Ranking(id: 7, username: 'User7', profilePicture: 'url7', logCount: 4),
      Ranking(id: 8, username: 'User8', profilePicture: 'url8', logCount: 3),
    ]);
  }

  @override
Future<List<ChallengeMember>> getMembersOfChallenge(int challengeId) {
  return Future.value([
    ChallengeMember(id: 1, username: 'user1', profilePicture: 'https://example.com/user1.jpg'),
    ChallengeMember(id: 2, username: 'user2', profilePicture: 'https://example.com/user2.jpg'),
    ChallengeMember(id: 3, username: 'user3', profilePicture: 'https://example.com/user3.jpg'),
    ChallengeMember(id: 4, username: 'user4', profilePicture: 'https://example.com/user4.jpg'),
    ChallengeMember(id: 5, username: 'user5', profilePicture: 'https://example.com/user5.jpg'),
    ChallengeMember(id: 6, username: 'user6', profilePicture: 'https://example.com/user6.jpg'),
    ChallengeMember(id: 7, username: 'user7', profilePicture: 'https://example.com/user7.jpg'),
    ChallengeMember(id: 8, username: 'user8', profilePicture: 'https://example.com/user8.jpg'),
    ChallengeMember(id: 9, username: 'user9', profilePicture: 'https://example.com/user9.jpg'),
    ChallengeMember(id: 10, username: 'user10', profilePicture: 'https://example.com/user10.jpg'),
    ChallengeMember(id: 11, username: 'user11', profilePicture: 'https://example.com/user11.jpg'),
    ChallengeMember(id: 12, username: 'user12', profilePicture: 'https://example.com/user12.jpg'),
    ChallengeMember(id: 13, username: 'user13', profilePicture: 'https://example.com/user13.jpg'),
    ChallengeMember(id: 14, username: 'user14', profilePicture: 'https://example.com/user14.jpg'),
    ChallengeMember(id: 15, username: 'user15', profilePicture: 'https://example.com/user15.jpg'),
  ]);
}

  @override
  Future<void> createGymChallenge(CreateGymChallengeDto createGymChallengeDto) {
    // TODO: implement createGymChallenge
    throw UnimplementedError();
  }
  
  @override
  Future<void> joinChallenge(String joinId) {
    // TODO: implement joinChallenge
    throw UnimplementedError();
  }

  @override
  Future<void> updateChallenge(int challengeId, UpdateGymChallengeDto updateGymChallengeDto) {
    // TODO: implement updateChallenge
    throw UnimplementedError();
  }
}
