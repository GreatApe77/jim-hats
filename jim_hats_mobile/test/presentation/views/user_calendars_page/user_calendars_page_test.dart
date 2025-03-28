import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/calendar/calendar.dart';

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
    expect(find.text('February 2025'),findsOne);
    //expect(find.text('March 2025'),findsOne);
    expect(find.byType(Calendar), findsExactly(1));
  });
}
