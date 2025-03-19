import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/network_exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/add_exercise_log_to_challenge_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/update_exercise_log_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_exercise_log_data_source_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  late NetworkExerciseLogDataSource sut;
  late HttpService mockHttpClient;
  final int testChallengeId = 7;
  final int testExerciseLogId = 77;
  final UpdateExerciseLogDto sampleUpdateExerciseLogDto =
      UpdateExerciseLogDto(description: 'Some changed description');
  final AddExerciseLogToChallengeDto sampleAddExerciseLogToChallengeDto =
      AddExerciseLogToChallengeDto(
    title: 'title',
    description: 'description',
    image: 'image.com',
  );
  setUp(
    () {
      mockHttpClient = MockHttpService();
      sut = NetworkExerciseLogDataSource(httpClient: mockHttpClient);
    },
  );

  group(
    'Get logs of challenge',
    () {
      test(
        'Should retrieve all logs of a challenge',
        () async {
          when(mockHttpClient.get('/gym-challenges/$testChallengeId/logs'))
              .thenAnswer(
            (_) async => {
              'data': [
                {
                  'id': 8,
                  'title': 'title',
                  'description': 'description',
                  'image': 'image',
                  'date': DateTime(2025).millisecondsSinceEpoch,
                  'userId': 9,
                  'gymChallengeId': testChallengeId,
                  'user': {'username': 'username', 'profilePicture': 'https'}
                },
                {
                  'id': 9,
                  'title': 'title',
                  'description': 'description',
                  'image': 'image',
                  'date': DateTime(2026).millisecondsSinceEpoch,
                  'userId': 9,
                  'gymChallengeId': testChallengeId,
                  'user': {'username': 'username', 'profilePicture': 'https'}
                }
              ]
            },
          );
          final result = await sut.getLogsOfChallenge(testChallengeId);
          expect(result.length, 2);
          expect(result[0], isA<ExerciseLogWithUser>());
        },
      );
    },
  );

  group(
    'Add exercise log to challenge',
    () {
      test(
        'Should add exercise log to challegne',
        () async {
          when(
            mockHttpClient.post(
              '/gym-challenges/$testChallengeId/logs',
              data: sampleAddExerciseLogToChallengeDto.toMap(),
            ),
          ).thenAnswer(
            (_) async => {},
          );
          await expectLater(
              sut.addExerciseLogToChallenge(
                  testChallengeId, sampleAddExerciseLogToChallengeDto),
              completes);
        },
      );
    },
  );

  group(
    'Get all exercise logs of user',
    () {
      test(
        'Should get all logs of user',
        () async {
          when(mockHttpClient.get('/users/me/logs')).thenAnswer(
            (_) async => {
              'data': [
                {
                  'id': 8,
                  'title': 'title',
                  'description': 'description',
                  'image': 'image',
                  'date': DateTime(2025).millisecondsSinceEpoch,
                  'userId': 9,
                  'gymChallengeId': testChallengeId,
                },
              ]
            },
          );
          final result = await sut.getAllLogsOfUser();
          expect(result.length, 1);
          expect(result[0], isA<ExerciseLog>());
          expect(result[0].title, 'title');
        },
      );
    },
  );

  group(
    'Delete exercise log',
    () {
      test(
        'Should delete an exercise log',
        () async {
          when(
            mockHttpClient.delete('/logs/$testExerciseLogId'),
          ).thenAnswer(
            (_) async => {},
          );
          await expectLater(
              sut.deleteExerciseLog(testExerciseLogId), completes);
        },
      );
    },
  );

  group(
    'Update exercise log',
    () {
      test(
        'Should update exercise log',
        () async {
          when(mockHttpClient.patch('/logs/$testExerciseLogId',
                  data: sampleUpdateExerciseLogDto.toMap()))
              .thenAnswer(
            (_) async => {},
          );
          await expectLater(
            sut.updateExerciseLog(
              testExerciseLogId,
              sampleUpdateExerciseLogDto,
            ),
            completes,
          );
        },
      );
    },
  );
}
