import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/memory_gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/create_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/update_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';

class NetworkGymChallengeDataSource implements MemoryGymChallengeDataSource {
  final HttpService _httpClient;
  // final SettingsDataSource _settingsDataSource;
  NetworkGymChallengeDataSource({
    required HttpService httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<GymChallenge> getGymChallengeById(int id) {
    // TODO: implement getGymChallengeById
    throw UnimplementedError();
  }

  @override
  Future<List<GymChallenge>> getGymChallengesOfUser(int userId) async {
    try {
      //final jwtToken = await _settingsDataSource.get<String>('token');
      final response = await _httpClient.get(
        '/users/$userId/gym-challenges',
      );
      final data = response['data'] as List;
      return data
          .map(
            (e) => GymChallenge.fromMap(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ChallengeMember>> getMembersOfChallenge(int challengeId) async {
    try {
      final response = await _httpClient.get(
        '/gym-challenges/$challengeId/members',
      );
      final data = response['data'] as List;
      return data
          .map(
            (e) => ChallengeMember.fromMap(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Ranking>> getRankingOfChallenge(int challengeId) async {
    try {
      final response = await _httpClient.get(
        '/gym-challenges/$challengeId/ranking',
      );
      final data = response['data'] as List;
      return data
          .map(
            (e) => Ranking.fromMap(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createGymChallenge(
      CreateGymChallengeDto createGymChallengeDto) async {
    try {
      await _httpClient.post(
        '/gym-challenges',
        data: createGymChallengeDto.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> joinChallenge(String joinId) async {
    try {
      await _httpClient.get(
        '/gym-challenges/$joinId/join',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateChallenge(
      int challengeId, UpdateGymChallengeDto updateGymChallengeDto) async {
    try {
      await _httpClient.patch(
        '/gym-challenges/$challengeId',
        data: updateGymChallengeDto.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
