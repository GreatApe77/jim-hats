import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/widgets/app_drawer/app_drawer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockAppDrawerCubit extends MockCubit<AppDrawerState>
    implements AppDrawerCubit {}

void main() {
  late AppDrawerCubit mockAppDrawerCubit;
  setUp(
    () {
      mockAppDrawerCubit = MockAppDrawerCubit();
    },
  );
  tearDown(
    () {
      mockAppDrawerCubit.close();
    },
  );
  testWidgets(
    'Should display initial static data',
    (widgetTester) async {
      when(
        () => mockAppDrawerCubit.state,
      ).thenReturn(AppDrawerInitial());
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppDrawer(
              appDrawerCubit: mockAppDrawerCubit,
            ),
          ),
        ),
      );
      expect(find.text('Create group'), findsOne);
      expect(find.text('Join group'), findsOne);
      expect(find.text('Completed challenges'), findsOne);
      expect(find.text('Settings'), findsOne);
      expect(find.text('Help & feedback'), findsOne);
      expect(find.text('About'), findsOne);
    },
  );
  testWidgets(
    'Should display loading state',
    (widgetTester) async {
      when(
        () => mockAppDrawerCubit.state,
      ).thenReturn(AppDrawerLoadDataInProgress());
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppDrawer(
              appDrawerCubit: mockAppDrawerCubit,
            ),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsAny);
    },
  );
  testWidgets(
    'Should navigate to settings page',
    (widgetTester) async {
      when(
        () => mockAppDrawerCubit.state,
      ).thenReturn(AppDrawerInitial());
      final scaffoldKey = GlobalKey<ScaffoldState>();
      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.settings: (context) =>
                Scaffold(body: const Text(AppRoutes.settings)),
          },
          home: Scaffold(
            key: scaffoldKey,
            drawer: AppDrawer(
              appDrawerCubit: mockAppDrawerCubit,
            ),
          ),
        ),
      );
      scaffoldKey.currentState?.openDrawer();
      await widgetTester.pumpAndSettle();
      final settingsListTile = find.byKey(
        const Key('AppDrawer.settings_list_tile'),
      );
      expect(settingsListTile, findsOneWidget);
      await widgetTester.tap(settingsListTile);
      await widgetTester.pumpAndSettle();
      expect(find.text(AppRoutes.settings), findsOne);
    },
  );
  testWidgets(
    'Should navigate to join group page',
    (widgetTester) async {
      when(
        () => mockAppDrawerCubit.state,
      ).thenReturn(AppDrawerInitial());
      final scaffoldKey = GlobalKey<ScaffoldState>();
      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.joinGroup: (context) =>
                Scaffold(body: const Text(AppRoutes.joinGroup)),
          },
          home: Scaffold(
            key: scaffoldKey,
            drawer: AppDrawer(
              appDrawerCubit: mockAppDrawerCubit,
            ),
          ),
        ),
      );
      scaffoldKey.currentState?.openDrawer();
      await widgetTester.pumpAndSettle();
      final joinGroupListTile = find.byKey(
        const Key('AppDrawer.join_group_list_tile'),
      );
      expect(joinGroupListTile, findsOneWidget);
      await widgetTester.tap(joinGroupListTile);
      await widgetTester.pumpAndSettle();
      expect(find.text(AppRoutes.joinGroup), findsOne);
    },
  );
  //AppDrawer.create_group_list_tile
  testWidgets(
    'Should navigate to create challenge page',
    (widgetTester) async {
      when(
        () => mockAppDrawerCubit.state,
      ).thenReturn(AppDrawerInitial());
      final scaffoldKey = GlobalKey<ScaffoldState>();
      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.createChallenge: (context) =>
                Scaffold(body: const Text(AppRoutes.createChallenge)),
          },
          home: Scaffold(
            key: scaffoldKey,
            drawer: AppDrawer(
              appDrawerCubit: mockAppDrawerCubit,
            ),
          ),
        ),
      );
      scaffoldKey.currentState?.openDrawer();
      await widgetTester.pumpAndSettle();
      final createGroupListTile = find.byKey(
        const Key('AppDrawer.create_group_list_tile'),
      );
      expect(createGroupListTile, findsOneWidget);
      await widgetTester.tap(createGroupListTile);
      await widgetTester.pumpAndSettle();
      expect(find.text(AppRoutes.createChallenge), findsOne);
    },
  );
  testWidgets(
    'Should display drawer data',
    (widgetTester) async {
      mockNetworkImagesFor(
        () async {
          when(
            () => mockAppDrawerCubit.state,
          ).thenReturn(
            AppDrawerLoadDataSuccess(
              loggedUser:
                  LoggedUser(id: 1, username: 'username', email: 'email'),
              challenges: [
                GymChallenge(
                  id: 1,
                  name: 'name',
                  description: 'description',
                  createdAt: DateTime(2025),
                  startAt: DateTime(2025),
                  endAt: DateTime(2025),
                  creatorId: 1,
                )
              ],
            ),
          );
          await widgetTester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: AppDrawer(
                  appDrawerCubit: mockAppDrawerCubit,
                ),
              ),
            ),
          );
        },
      );
    },
  );
  /* testWidgets(
    'Should navigate to user stats page',
    (widgetTester) async {
      mockNetworkImagesFor(
        () async {
          when(
            () => mockAppDrawerCubit.state,
          ).thenReturn(
            AppDrawerLoadDataSuccess(
              loggedUser:
                  LoggedUser(id: 1, username: 'USERNAME', email: 'email'),
              challenges: [
                GymChallenge(
                  id: 1,
                  name: 'name',
                  description: 'description',
                  createdAt: DateTime(2025),
                  startAt: DateTime(2025),
                  endAt: DateTime(2025),
                  creatorId: 1,
                )
              ],
            ),
          );
          final scaffoldKey = GlobalKey<ScaffoldState>();
          await widgetTester.pumpWidget(
            MaterialApp(
              routes: {
                AppRoutes.userStats: (context) =>
                    Scaffold(body: const Text(AppRoutes.userStats)),
              },
              home: Scaffold(
                drawer: AppDrawer(
                  appDrawerCubit: mockAppDrawerCubit,
                ),
              ),
            ),
          );
          scaffoldKey.currentState?.openDrawer();
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(find.byKey(
            const Key('AppDrawer.logged_user_list_tile'),
          ));
          await widgetTester.pumpAndSettle();
          expect(find.text(AppRoutes.userStats), findsOne);
        },
      );
    },
  ); */
}
