import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/locator.dart';

import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/user_stats_page/user_stats_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/user_stats/user_stats_page.dart';
import 'package:jim_hats_mobile/presentation/views/user_stats/widgets/stats_item.dart';
import 'package:jim_hats_mobile/presentation/widgets/calendar/calendar.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockAppDrawerCubit extends MockCubit<AppDrawerState>
    implements AppDrawerCubit {}

class MockUserStatsCubit extends MockCubit<UserStatsState>
    implements UserStatsCubit {}

void main() {
  late UserStatsCubit mockUserStatsCubit;
  final sampleLoggedUser =
      LoggedUser(id: 1, username: 'mateus', email: 'email');
  final sampleLogsOfUser = [
    ExerciseLog(
      id: 1,
      title: 'title1',
      date: DateTime(2025, 2, 5),
      userId: 1,
      gymChallengeId: 2,
    ),
    ExerciseLog(
      id: 1,
      title: 'title1',
      date: DateTime(2025, 2, 6),
      userId: 1,
      gymChallengeId: 2,
    ),
  ];
  setUp(
    () {
      mockUserStatsCubit = MockUserStatsCubit();

      locator.registerFactory<UserStatsCubit>(
        () => mockUserStatsCubit,
      );
      locator.registerFactory<AppDrawerCubit>(
        () => MockAppDrawerCubit(),
      );
    },
  );
  tearDown(
    () {
      locator.unregister<UserStatsCubit>();
      locator.unregister<AppDrawerCubit>();
    },
  );

  testWidgets(
    'Should display empty data',
    (widgetTester) async {
      whenListen(
        mockUserStatsCubit,
        Stream<UserStatsState>.fromIterable([]),
        initialState: UserStatsInitial(),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: UserStatsPage(),
        ),
      );
      //await widgetTester.pump();
      expect(
        find.byKey(Key('UserStatsView.shrinked_sized_box')),
        findsOne,
      );
      //Key('UserStatsView.shrinked_sized_box')
    },
  );
  testWidgets(
    'Should display circular progress indicator when loading',
    (widgetTester) async {
      whenListen(
        mockUserStatsCubit,
        Stream<UserStatsState>.fromIterable([
          UserStatsDataLoadInProgess(),
        ]),
        initialState: UserStatsInitial(),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: UserStatsPage(),
        ),
      );
      await widgetTester.pump();
      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
      //Key('UserStatsView.shrinked_sized_box')
    },
  );
  testWidgets(
    'Should display page data',
    (widgetTester) async {
      mockNetworkImagesFor(
        () async {
          whenListen(
            mockUserStatsCubit,
            Stream<UserStatsState>.fromIterable([
              UsersStatsDataSuccess(
                loggedUser: sampleLoggedUser,
                logsOfUser: sampleLogsOfUser,
              )
            ]),
            initialState: UserStatsInitial(),
          );
          await widgetTester.pumpWidget(
            MaterialApp(
              home: UserStatsPage(),
            ),
          );
          await widgetTester.pump();
          expect(
            find.byType(Calendar),
            findsOneWidget,
          );
          final totalCountStatsItem =
              find.byKey(Key('UserStatsView.total_stats_item'));
          expect(totalCountStatsItem, findsOneWidget);
          expect(
            (widgetTester.widget(totalCountStatsItem) as StatsItem).value,
            '2',
          );
        },
      );
      //Key('UserStatsView.shrinked_sized_box')
    },
  );
  // testWidgets(
  //   'Should display modal on day tap',
  //   (widgetTester) async {
  //     fakeAsync((async) async {
  //       whenListen(
  //         mockUserStatsCubit,
  //         Stream<UserStatsState>.fromIterable([
  //           UsersStatsDataSuccess(
  //             loggedUser: sampleLoggedUser,
  //             logsOfUser: sampleLogsOfUser,
  //           )
  //         ]),
  //         initialState: UserStatsInitial(),
  //       );
  //       await widgetTester.pumpWidget(
  //         MaterialApp(
  //           home: UserStatsPage(),
  //         ),
  //       );
  //       final february5of2025 =
  //           find.byKey(Key('Calendar.dayWithActitvity_5/2/2025'));
  //       await widgetTester.tap(february5of2025);
  //       await widgetTester.pumpAndSettle();
  //       expect(find.byType(ExerciseLogTile), findsAny);
  //     }, initialTime: DateTime(2025, 2, 20));
  //     //Key('UserStatsView.shrinked_sized_box')
  //   },
  // );
}
