import 'package:jim_hats_mobile/data/gym_challenges/dtos/create_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/update_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';

abstract class GymChallengeDataSource {
  Future<GymChallenge> getGymChallengeById(int id);
  Future<List<GymChallenge>> getGymChallengesOfUser(int userId);
  Future<List<Ranking>> getRankingOfChallenge(int challengeId);
  Future<List<ChallengeMember>> getMembersOfChallenge(int challengeId);
  Future<void> createGymChallenge(
      CreateGymChallengeDto createGymChallengeDto);
  Future<void> joinChallenge(String joinId);
  Future<void> updateChallenge(int challengeId,UpdateGymChallengeDto updateGymChallengeDto);
}
