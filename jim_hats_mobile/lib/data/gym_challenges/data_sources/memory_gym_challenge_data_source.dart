import 'package:jim_hats_mobile/data/gym_challenges/data_sources/gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';

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
}
