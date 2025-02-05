import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';

abstract class GymChallengeDataSource {
  Future<GymChallenge> getGymChallengeById(int id);
  Future<List<GymChallenge>> getGymChallengesOfUser(int userId);
}