import 'package:jim_hats_mobile/core/utils/cache_service.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/create_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/update_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/locator.dart';

class GymChallengesRepository {
  final GymChallengeDataSource _gymChallengeDataSource;
  final CacheService _cacheService;
  GymChallengesRepository({
    required GymChallengeDataSource? gymChallengeDataSource,
    required CacheService cacheService,
  })  : _cacheService = cacheService,
        _gymChallengeDataSource =
            gymChallengeDataSource ?? locator.get<GymChallengeDataSource>();

  Future<List<GymChallenge>> getGymChallengesOfUser(int userId) async {
    List<GymChallenge>? challenges =
        _cacheService.get<List<GymChallenge>>('challenges');
    if (challenges == null) {
      //await Future.delayed(Duration(seconds: 2));
      challenges = await _gymChallengeDataSource.getGymChallengesOfUser(userId);
      _cacheService.store<List<GymChallenge>>(
        'challenges',
        challenges,
        duration: Duration(minutes: 1),
      );
    }
    //final challenges = await _gymChallengeDataSource.getGymChallengesOfUser(userId);
    return challenges;
  }

  Future<List<Ranking>> getRankingsOfChallenge(int challengeId) async {
    List<Ranking>? rankings =
        _cacheService.get<List<Ranking>>('ranking-$challengeId');
    if (rankings == null) {
      //await Future.delayed(Duration(seconds: 2));
      rankings =
          await _gymChallengeDataSource.getRankingOfChallenge(challengeId);
      _cacheService.store<List<Ranking>>(
        'ranking-$challengeId',
        rankings,
        duration: Duration(minutes: 1),
      );
    }
    return rankings;
  }

  Future<List<ChallengeMember>> getMembersOfChallenge(int challengeId) async {
    List<ChallengeMember>? challengeMembers =
        _cacheService.get<List<ChallengeMember>>('members-$challengeId');
    if (challengeMembers == null) {
      //await Future.delayed(Duration(seconds: 2));
      challengeMembers =
          await _gymChallengeDataSource.getMembersOfChallenge(challengeId);
      _cacheService.store<List<ChallengeMember>>(
          'members-$challengeId', challengeMembers,
          duration: Duration(minutes: 1));
    }
    return challengeMembers;
  }

  Future<void> createGymChallenge(
      CreateGymChallengeDto createGymChallengeDto) async {
    await _gymChallengeDataSource.createGymChallenge(createGymChallengeDto);
    _cacheService.remove('challenges');
  }

  Future<void> joinChallenge(String joinId) async {
    await _gymChallengeDataSource.joinChallenge(joinId);
    _cacheService.remove('challenges');
  }

  Future<void> updateGymChallenge(
    int challengeId,
    UpdateGymChallengeDto updateGymChallengeDto,
  ) async {
    await _gymChallengeDataSource.updateChallenge(
        challengeId, updateGymChallengeDto);
    _cacheService.remove('challenges-$challengeId');
  }
}
