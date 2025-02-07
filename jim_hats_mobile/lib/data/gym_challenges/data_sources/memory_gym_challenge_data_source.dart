import 'package:jim_hats_mobile/data/gym_challenges/data_sources/gym_challenge_data_source.dart';
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
          image: null,
          joinId: null,
          createdAt: DateTime.now(),
          startAt: DateTime.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch + 20000000),
          endAt: DateTime.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch + 80000000),
          creatorId: 1),
      GymChallenge(
          id: 6,
          name: 'Challenge 6',
          description: 'Challenge Description 6',
          image: null,
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
}
