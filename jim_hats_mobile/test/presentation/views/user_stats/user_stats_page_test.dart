import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';

import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/user_stats_page/user_stats_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/user_stats/user_stats_page.dart';
import 'package:mocktail/mocktail.dart';

class MockAppDrawerCubit extends MockCubit<AppDrawerState>
    implements AppDrawerCubit {}

class MockUserStatsCubit extends MockCubit<UserStatsState>
    implements UserStatsCubit {}

void main() {
  late UserStatsCubit mockUserStatsCubit;
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
        Stream<UserStatsState>.fromIterable([
        ]),
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
}
