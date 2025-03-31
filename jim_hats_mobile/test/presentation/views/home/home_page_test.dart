import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/home/home_page.dart';
import 'package:mocktail/mocktail.dart';

class MockHomePageCubit extends MockCubit<HomePageState>
    implements HomePageCubit {}

class MockAppDrawerCubit extends MockCubit<AppDrawerState>
    implements AppDrawerCubit {}

void main() {
  late HomePageCubit mockHomePageCubit;

  setUp(
    () {
      mockHomePageCubit = MockHomePageCubit();
      locator.registerFactory<HomePageCubit>(
        () => mockHomePageCubit,
      );
      locator.registerFactory<AppDrawerCubit>(
        () => MockAppDrawerCubit(),
      );
    },
  );
  tearDown(
    () {
      locator.unregister<HomePageCubit>();
      locator.unregister<AppDrawerCubit>();
    },
  );

  testWidgets(
    'Should display nothing in inital data',
    (widgetTester) async {
      whenListen(
        mockHomePageCubit,
        Stream<HomePageState>.fromIterable([]),
        initialState: HomePageDataInitial(),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );
      expect(
        find.byKey(
          Key('HomeView.shrinked_sized_box'),
        ),
        findsOne,
      );
    },
  );
  testWidgets(
    'Should display circular progress indicator when loading data',
    (widgetTester) async {
      whenListen(mockHomePageCubit,
          Stream<HomePageState>.fromIterable([HomePageDataLoading()]),
          initialState: HomePageDataInitial());

      await widgetTester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );
      await widgetTester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
  testWidgets(
    'Should display logged user information when data is fetched',
    (widgetTester) async {
      whenListen(
          mockHomePageCubit,
          Stream<HomePageState>.fromIterable([
            HomePageDataSuccess(
              loggedUser: LoggedUser(
                  id: 9, username: 'mateus', email: 'mateus@email.com'),
            )
          ]),
          initialState: HomePageDataInitial());

      await widgetTester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );
      await widgetTester.pump();
      expect(find.textContaining('Hello, mateus'), findsOneWidget);
      //expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
