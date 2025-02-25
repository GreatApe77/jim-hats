import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/memory_gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/create_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:jim_hats_mobile/shared/http/http_client.dart';

class NetworkGymChallengeDataSource implements MemoryGymChallengeDataSource {
  final HttpClient _httpClient;
  final SettingsDataSource _settingsDataSource;
  NetworkGymChallengeDataSource({
    required HttpClient httpClient,
    required SettingsDataSource settingsDataSource,
  })  : _settingsDataSource = settingsDataSource,
        _httpClient = httpClient;

  @override
  Future<GymChallenge> getGymChallengeById(int id) {
    // TODO: implement getGymChallengeById
    throw UnimplementedError();
  }

  @override
  Future<List<GymChallenge>> getGymChallengesOfUser(int userId) async {
    try {
      final jwtToken = await _settingsDataSource.get<String>('token');
      final response = await _httpClient.dio.get<Map<String, dynamic>>(
          '/users/$userId/gym-challenges',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      final data = response.data?['data'] as List;
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
      final jwtToken = await _settingsDataSource.get<String>('token');
      final response = await _httpClient.dio.get<Map<String, dynamic>>(
          '/gym-challenges/$challengeId/members',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      final data = response.data?['data'] as List;
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
      final jwtToken = await _settingsDataSource.get<String>('token');
      final response = await _httpClient.dio.get<Map<String, dynamic>>(
          '/gym-challenges/$challengeId/ranking',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
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

  @override
  Future<void> createGymChallenge(
      CreateGymChallengeDto createGymChallengeDto) async {
    try {
      final jwtToken = await _settingsDataSource.get<String>('token');
      await _httpClient.dio.post<Map<String, dynamic>>('/gym-challenges',
          data: createGymChallengeDto.toMap(),
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
    } catch (e) {
      rethrow;
    }
  }
}
