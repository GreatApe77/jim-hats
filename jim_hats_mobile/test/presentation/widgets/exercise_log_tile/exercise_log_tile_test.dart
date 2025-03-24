import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/presentation/widgets/exercise_log_tile/exercise_log_tile.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  final sampleExerciseLog = ExerciseLogWithUser(
    user: User(username: 'mateus'),
    id: 5,
    title: 'Exercise',
    date: DateTime(2025, 3, 24, 17, 50),
    userId: 9,
    gymChallengeId: 10,
  );
  group(
    'Exercise log tile tests',
    () {
      testWidgets(
        'Should display exercise log with user information',
        (tester) async {
          mockNetworkImagesFor(
            () async {
              await tester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: ExerciseLogTile(
                      exerciseLogWithUser: sampleExerciseLog,
                      onTap: () {},
                    ),
                  ),
                ),
              );

              final exerciseHour = find.textContaining('17:50');
              final exerciseOwner = find.textContaining('mateus');
              final exerciseTitle = find.textContaining('Exercise');
              expect(exerciseTitle, findsOne);
              expect(exerciseHour, findsOne);
              expect(exerciseOwner, findsOne);
            },
          );
        },
      );
    },
  );
}
