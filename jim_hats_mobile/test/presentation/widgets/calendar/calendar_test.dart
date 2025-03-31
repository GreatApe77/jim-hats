import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/presentation/widgets/calendar/calendar.dart';

void main() {
  final sampleCalendarDateTime = DateTime(2025, 3);
  final sampleExerciseLogList = [
    ExerciseLog(
      id: 1,
      title: 'title',
      date: DateTime(2025, 3, 1),
      userId: 2,
      gymChallengeId: 3,
    ),
    ExerciseLog(
      id: 2,
      title: 'title2',
      date: DateTime(2025, 3, 25),
      userId: 2,
      gymChallengeId: 3,
    ),
    ExerciseLog(
      id: 2,
      title: 'title3',
      date: DateTime(2025, 3, 25),
      userId: 2,
      gymChallengeId: 3,
    ),
  ];
  group(
    'Calendar widget tests',
    () {
      testWidgets('Should display correct month and year', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ListView(
              children: [
                Calendar(
                  date: sampleCalendarDateTime,
                  logsOfTheMonth: sampleExerciseLogList,
                  onDayTap: (day, logs) {},
                )
              ],
            ),
          ),
        );
        final title = find.textContaining('March 2025');
        expect(title, findsOne);
      });
      testWidgets('Should display days of the week', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ListView(
              children: [
                Calendar(
                  date: sampleCalendarDateTime,
                  logsOfTheMonth: sampleExerciseLogList,
                  onDayTap: (day, logs) {},
                )
              ],
            ),
          ),
        );
        final sundayText = find.textContaining('Sun');
        final mondayText = find.textContaining('Mon');
        final tuesdayText = find.textContaining('Tue');
        final wednesdayText = find.textContaining('Wed');
        final thursdayText = find.textContaining('Thu');
        final fridayText = find.textContaining('Fri');
        final saturdayText = find.textContaining('Sat');
        expect(sundayText, findsOne);
        expect(mondayText, findsOne);
        expect(tuesdayText, findsOne);
        expect(wednesdayText, findsOne);
        expect(thursdayText, findsOne);
        expect(fridayText, findsOne);
        expect(saturdayText, findsOne);
      });
      testWidgets('Should display 31 days of march', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ListView(
              children: [
                Calendar(
                  date: sampleCalendarDateTime,
                  logsOfTheMonth: sampleExerciseLogList,
                  onDayTap: (day, logs) {},
                )
              ],
            ),
          ),
        );
        final dayContainers = find.byKey(Key('Calendar.days'));
        expect(dayContainers, findsExactly(31));
      });
      // testWidgets(
      //     'Execute a callback for each day with logged exercises for march 2025',
      //     (tester) async {
      //   int count = 0;
      //   void sampleCallback(int day, List<ExerciseLog> exerciseLogsOfThisDay) {
      //     count++;
      //   }

      //   await tester.pumpWidget(
      //     MaterialApp(
      //       home: ListView(
      //         children: [
      //           Calendar(
      //             date: sampleCalendarDateTime,
      //             logsOfTheMonth: sampleExerciseLogList,
      //             onDayTap: sampleCallback,
      //           )
      //         ],
      //       ),
      //     ),
      //   );
        
      //   for (final iconButton
      //       in find.byKey(Key('Calendar.dayWithActivity')).evaluate()) {
      //     await tester.tap(find.byWidget(iconButton.widget));
      //     await tester.pump();
      //   }
      //   expect(count, 2);
      // });
    },
  );
}
