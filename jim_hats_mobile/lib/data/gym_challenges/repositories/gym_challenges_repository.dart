import 'package:jim_hats_mobile/data/gym_challenges/data_sources/gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/shared/utils/memory_cache.dart';

class GymChallengesRepository {
  final GymChallengeDataSource _gymChallengeDataSource;

  GymChallengesRepository(
      {required GymChallengeDataSource gymChallengeDataSource})
      : _gymChallengeDataSource = gymChallengeDataSource;

  Future<List<GymChallenge>> getGymChallengesOfUser(int userId) async {
    List<GymChallenge>? challenges =
        MemoryCache.get<List<GymChallenge>>('challenges');
    if (challenges == null) {
      await Future.delayed(Duration(seconds: 2));
      challenges = await _gymChallengeDataSource.getGymChallengesOfUser(userId);
      MemoryCache.store<List<GymChallenge>>('challenges', challenges,
          duration: Duration(minutes: 1));
    }
    //final challenges = await _gymChallengeDataSource.getGymChallengesOfUser(userId);
    return Future.value(challenges);
  }

  Future<List<Ranking>> getRankingsOfChallenge(int challengeId) async {
    List<Ranking>? rankings =
        MemoryCache.get<List<Ranking>>('ranking');
    if(rankings==null){
      await Future.delayed(Duration(seconds: 2));
      rankings = await _gymChallengeDataSource.getRankingOfChallenge(challengeId);
    }
    return rankings;
  }
}
