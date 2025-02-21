import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/memory_gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/shared/http/http_client.dart';

class NetworkGymChallengeDataSource implements MemoryGymChallengeDataSource {
  final HttpClient _httpClient;

  NetworkGymChallengeDataSource({required HttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<GymChallenge> getGymChallengeById(int id) {
    // TODO: implement getGymChallengeById
    throw UnimplementedError();
  }

  @override
  Future<List<GymChallenge>> getGymChallengesOfUser(int userId) {
    // TODO: implement getGymChallengesOfUser
    throw UnimplementedError();
  }

  @override
  Future<List<ChallengeMember>> getMembersOfChallenge(int challengeId) async {
    throw Error();
    //
    // try {
    //   final response = await _httpClient.dio.get<Map<String,dynamic>>('/gym-challenge/${challengeId}/log')

    // } catch (e) {}
  }

  @override
  Future<List<Ranking>> getRankingOfChallenge(int challengeId) async {
    try {
      final response = await _httpClient.dio
          .get<Map<String, dynamic>>('/gym-challenge/$challengeId/ranking');
      final data = response.data?['data'] as List;
      return data
          .map(
            (e) => Ranking.fromMap(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
