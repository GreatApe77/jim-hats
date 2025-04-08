import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/exercise_log_tile/exercise_log_tile.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  final sampleLoggedUser = LoggedUser(
    id: 1,
    username: 'Mateus',
    email: 'mateus@email.com',
  );
  final sampleLogsGroupedByDate = {
    '02/2025': [
      ExerciseLog(
        id: 1,
        title: 'title1',
        date: DateTime(2025, 2, 3),
        userId: 1,
        gymChallengeId: 2,
      ),
      ExerciseLog(
        id: 2,
        title: 'title2',
        date: DateTime(2025, 2, 8),
        userId: 1,
        gymChallengeId: 2,
      )
    ],
    '03/2025': [
      ExerciseLog(
        id: 1,
        title: 'title3',
        date: DateTime(2025, 3, 3),
        userId: 1,
        gymChallengeId: 2,
      ),
      ExerciseLog(
        id: 2,
        title: 'title4',
        date: DateTime(2025, 3, 8),
        userId: 1,
        gymChallengeId: 2,
      )
    ]
  };
  testWidgets('Should display 2 calendars', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: UserCalendarsPage(
          calendarsPageArguments: UserCalendarsPageArguments(
            exerciseLogsGroupedByDate: sampleLogsGroupedByDate,
            loggedUser: sampleLoggedUser,
          ),
        ),
      ),
    );
    await tester.pump();
    //
    expect(find.text('February 2025'), findsOne);
    //expect(find.text('March 2025'),findsOne);
    //expect(find.byType(Calendar), findsExactly(1));
  });
  testWidgets(
    'Should display a modal when clicking in a day with activity',
    (tester) async {
      mockNetworkImagesFor(
        () async {
          //Calendar.dayWithActitvity_/$day/${date.month}/${date.year}
          await tester.pumpWidget(
            MaterialApp(
              home: UserCalendarsPage(
                calendarsPageArguments: UserCalendarsPageArguments(
                  exerciseLogsGroupedByDate: sampleLogsGroupedByDate,
                  loggedUser: sampleLoggedUser,
                ),
              ),
            ),
          );
          await tester.pump();
          final february3Of2025 = find.byKey(
            Key('Calendar.dayWithActitvity_3/2/2025'),
          );
          await tester.tap(february3Of2025);
          await tester.pumpAndSettle();
          expect(find.byType(ExerciseLogTile), findsAny);
        },
      );
    },
  );
  testWidgets(
    'Should Navigate to check in page when clicking on exercise log tile of the modal',
    (tester) async {
      mockNetworkImagesFor(
        () async {
          //Calendar.dayWithActitvity_/$day/${date.month}/${date.year}
          await tester.pumpWidget(
            MaterialApp(
              routes: {
                AppRoutes.checkIn: (context) => Scaffold(
                      body: const Text(
                        AppRoutes.checkIn,
                      ),
                    )
              },
              home: UserCalendarsPage(
                calendarsPageArguments: UserCalendarsPageArguments(
                  exerciseLogsGroupedByDate: sampleLogsGroupedByDate,
                  loggedUser: sampleLoggedUser,
                ),
              ),
            ),
          );
          await tester.pump();
          final february3Of2025 = find.byKey(
            Key('Calendar.dayWithActitvity_3/2/2025'),
          );
          await tester.tap(february3Of2025);
          await tester.pumpAndSettle();
          await tester.tap(find.byType(ExerciseLogTile));
          await tester.pumpAndSettle();
          expect(find.text(AppRoutes.checkIn), findsOne);
        },
      );
    },
  );
}
