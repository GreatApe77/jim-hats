import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/edit_gym_challenge_page/edit_gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/internet_connectivity/cubit/internet_connectivity_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/settings_page/settings_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_router.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/create-chalenge/create_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/server_down/server_down_alert_page.dart';
import 'package:jim_hats_mobile/presentation/views/settings/settings_page.dart';
import 'package:jim_hats_mobile/presentation/views/welcome/welcome_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

class MockAppDrawerCubit extends MockCubit<AppDrawerState>
    implements AppDrawerCubit {}

class MockEditGymChallengePageCubit extends MockCubit<EditGymChallengePageState>
    implements EditGymChallengePageCubit {}

void main() {
  testWidgets(
    'Should route to welcome page',
    (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        initialRoute: AppRoutes.welcome,
        onGenerateRoute: AppRouter.ongenerateRoute,
      ));
      expect(find.byType(WelcomePage), findsOneWidget);
    },
  );
  testWidgets(
    'Should route to server down',
    (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        initialRoute: AppRoutes.serverDown,
        onGenerateRoute: AppRouter.ongenerateRoute,
      ));
      expect(find.byType(ServerDownAlertPage), findsOneWidget);
    },
  );
  // testWidgets(
  //   'Should route to create challenge page',
  //   (widgetTester) async {
  //     await widgetTester.pumpWidget(MaterialApp(
  //       initialRoute: AppRoutes.createChallenge,
  //       onGenerateRoute: AppRouter.ongenerateRoute,
  //     ));
  //     expect(find.byType(CreateChallengePage), findsOneWidget);
  //   },
  // );
  test(
    'Should initialize bloc providers for global bloc/cubit',
    () {
      final themeBlocProv = blocProviders.firstWhere(
        (element) => element is BlocProvider<ThemeBloc>,
      );
      final authBlocProvider = blocProviders.firstWhere(
        (element) => element is BlocProvider<AuthCubit>,
      );
      final internetConnecivityBlocProvider = blocProviders.firstWhere(
        (element) => element is BlocProvider<InternetConnectivityCubit>,
      );
      expect(themeBlocProv, isA<BlocProvider>());
      expect(authBlocProvider, isA<BlocProvider>());
      expect(internetConnecivityBlocProvider, isA<BlocProvider>());
    },
  );
  group(
    'Settings page',
    () {
      late MockSettingsCubit mockSettingsCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockSettingsCubit = MockSettingsCubit();
          locator.registerFactory<SettingsCubit>(
            () => mockSettingsCubit,
          );
          locator.registerFactory<AppDrawerCubit>(
            () => mockAppDrawerCubit,
          );
        },
      );
      tearDown(
        () async {
          await locator.reset();
        },
      );
      testWidgets(
        'Should route to settings page',
        (widgetTester) async {
          when(
            () => mockSettingsCubit.state,
          ).thenReturn(SettingsInitial());
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(AppRoutes.settings);
          await widgetTester.pumpAndSettle();
          expect(find.byType(SettingsPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Edit Gym Challenge',
    () {
      late MockEditGymChallengePageCubit mockEditGymChallengePageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockEditGymChallengePageCubit = MockEditGymChallengePageCubit();
          locator.registerFactory<EditGymChallengePageCubit>(
            () => mockEditGymChallengePageCubit,
          );
          locator.registerFactory<AppDrawerCubit>(
            () => mockAppDrawerCubit,
          );
        },
      );
      tearDown(
        () async {
          await locator.reset();
        },
      );
      testWidgets(
        'Should route to edit gym challenge page',
        (widgetTester) async {
          when(
            () => mockEditGymChallengePageCubit.state,
          ).thenReturn(
            EditGymChallengePageState(
                status: EditGymChallengePageStatus.idle,
                imageUrl: '',
                name: 'name',
                description: 'description',
                startAt: DateTime(2025),
                endAt: DateTime(2025),
                errorMessage: '',
                image: null),
          );
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(
            AppRoutes.editGymChallenge,
            arguments: EditGymChallengePageArguments(
              gymChallenge: GymChallenge(
                  id: 1,
                  name: 'name',
                  description: 'description',
                  createdAt: DateTime(
                    2025,
                  ),
                  startAt: DateTime(
                    2025,
                  ),
                  endAt: DateTime(
                    2025,
                  ),
                  creatorId: 9),
            ),
          );
          await widgetTester.pumpAndSettle();
          expect(find.byType(EditGymChallengePage), findsOneWidget);
        },
      );
    },
  );
}
