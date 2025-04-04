import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/blocs/sign_in_page/sign_in_page_bloc.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/check_in_page/check_in_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_account_page/create_account_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_challenge_page/create_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/edit_check_in_page/edit_check_in_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/edit_gym_challenge_page/edit_gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_details_page/gym_challenge_details_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_page/gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/internet_connectivity/cubit/internet_connectivity_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/join_group_page/join_group_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/new_check_in_page/new_check_in_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/ranking_page/ranking_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/settings_page/settings_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/user_stats_page/user_stats_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_router.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/check_in_page/check_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/check_in_page/check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/create-chalenge/create_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/create_account/create_account_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_check_in/edit_check_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_check_in/edit_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge_details/gym_challenge_details_page.dart';
import 'package:jim_hats_mobile/presentation/views/home/home_page.dart';
import 'package:jim_hats_mobile/presentation/views/join_group/join_group_page.dart';
import 'package:jim_hats_mobile/presentation/views/new_check_in/new_check_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/new_check_in/new_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/ranking/ranking_page.dart';
import 'package:jim_hats_mobile/presentation/views/ranking/ranking_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/server_down/server_down_alert_page.dart';
import 'package:jim_hats_mobile/presentation/views/settings/settings_page.dart';
import 'package:jim_hats_mobile/presentation/views/sign_in/sign_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/user_stats/user_stats_page.dart';
import 'package:jim_hats_mobile/presentation/views/welcome/welcome_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

class MockAppDrawerCubit extends MockCubit<AppDrawerState>
    implements AppDrawerCubit {}

class MockEditGymChallengePageCubit extends MockCubit<EditGymChallengePageState>
    implements EditGymChallengePageCubit {}

class MockJoinGroupPageCubit extends MockCubit<JoinGroupPageState>
    implements JoinGroupPageCubit {}

class MockCreateChallengePageCubit extends MockCubit<CreateChallengePageState>
    implements CreateChallengePageCubit {}

class MockCheckInPageCubit extends MockCubit<CheckInPageState>
    implements CheckInPageCubit {}

class MockGymChallengePageCubit extends MockCubit<GymChallengePageState>
    implements GymChallengePageCubit {}

class MockUserStatsCubit extends MockCubit<UserStatsState>
    implements UserStatsCubit {}

class MockRankingPageCubit extends MockCubit<RankingPageState>
    implements RankingPageCubit {}

class MockNewCheckInPageCubit extends MockCubit<NewCheckInPageState>
    implements NewCheckInPageCubit {}

class MockGymChallengeDetailsPageCubit
    extends MockCubit<GymChallengeDetailsPageState>
    implements GymChallengeDetailsPageCubit {}

class MockHomePageCubit extends MockCubit<HomePageState>
    implements HomePageCubit {}

class MockSignInPageBloc extends MockBloc<SignInPageEvent, SignInPageState>
    implements SignInPageBloc {}

class MockEditCheckInPageCubit extends MockCubit<EditCheckInPageState>
    implements EditCheckInPageCubit {}

class MockCreateAccountPageCubit extends MockCubit<CreateAccountPageState>
    implements CreateAccountPageCubit {}

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

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
  group(
    'User calendars page ',
    () {
      testWidgets(
        'Should route to User calendars page',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(AppRoutes.userCalendars,
              arguments: UserCalendarsPageArguments(
                exerciseLogsGroupedByDate: {},
                loggedUser:
                    LoggedUser(id: 1, username: 'username', email: 'email'),
              ));
          await widgetTester.pumpAndSettle();
          expect(find.byType(UserCalendarsPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Join group page ',
    () {
      late MockJoinGroupPageCubit mockJoinGroupPageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockJoinGroupPageCubit = MockJoinGroupPageCubit();
          locator.registerFactory<JoinGroupPageCubit>(
            () => mockJoinGroupPageCubit,
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
        'Should route to join group page',
        (widgetTester) async {
          when(
            () => mockJoinGroupPageCubit.state,
          ).thenReturn(JoinGroupPageState(
              groupCode: '',
              status: JoinGroupPageStatus.idle,
              errorMessage: ''));
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(
            AppRoutes.joinGroup,
          );
          await widgetTester.pumpAndSettle();
          expect(find.byType(JoinGroupPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Create challenge',
    () {
      late MockCreateChallengePageCubit mockCreateChallengePageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockCreateChallengePageCubit = MockCreateChallengePageCubit();
          locator.registerFactory<CreateChallengePageCubit>(
            () => mockCreateChallengePageCubit,
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
        'Should route to create challenge page',
        (widgetTester) async {
          when(
            () => mockCreateChallengePageCubit.state,
          ).thenReturn(
            CreateChallengePageState(
              status: CreateChallengePageStatus.idle,
              name: 'name',
              description: 'description',
              startAt: DateTime(2025),
              endAt: DateTime(2025),
              errorMessage: '',
              image: null,
            ),
          );
          when(() => mockCreateChallengePageCubit.formatDate(any()))
              .thenReturn('02/02/2002');
          when(() => mockCreateChallengePageCubit.getDayCount(any(), any()))
              .thenReturn(99);

          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(AppRoutes.createChallenge);
          await widgetTester.pumpAndSettle();
          expect(find.byType(CreateChallengePage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Check in',
    () {
      late MockCheckInPageCubit mockCheckInPageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockCheckInPageCubit = MockCheckInPageCubit();
          locator.registerFactory<CheckInPageCubit>(
            () => mockCheckInPageCubit,
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
        'Should route to check in page',
        (widgetTester) async {
          when(
            () => mockCheckInPageCubit.state,
          ).thenReturn(CheckInPageInitial());
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(
            AppRoutes.checkIn,
            arguments: CheckInPageArguments(
              exerciseLog:
                  //ExerciseLogWithUser(user: User(username: username), id: id, title: title, date: date, userId: userId, gymChallengeId: gymChallengeId)
                  ExerciseLogWithUser(
                user: User(username: 'username'),
                id: 1,
                title: 'title',
                date: DateTime(2025),
                userId: 1,
                gymChallengeId: 1,
              ),
            ),
          );
          await widgetTester.pumpAndSettle();
          expect(find.byType(CheckInPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Gym challenge page',
    () {
      late MockGymChallengePageCubit mockGymChallengePageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockGymChallengePageCubit = MockGymChallengePageCubit();
          locator.registerFactory<GymChallengePageCubit>(
            () => mockGymChallengePageCubit,
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
        'Should route to gym challenge page',
        (widgetTester) async {
          when(
            () => mockGymChallengePageCubit.state,
          ).thenReturn(GymChallengePageInitial());

          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(
            AppRoutes.gymChallenge,
            arguments: GymChallengePageArguments(challengeId: 2),
          );
          await widgetTester.pumpAndSettle();
          expect(find.byType(GymChallengePage), findsOneWidget);
        },
      );
    },
  );
  group(
    'User stats',
    () {
      late MockUserStatsCubit mockUserStatsCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockUserStatsCubit = MockUserStatsCubit();
          locator.registerFactory<UserStatsCubit>(
            () => mockUserStatsCubit,
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
        'Should route to user stats page',
        (widgetTester) async {
          when(
            () => mockUserStatsCubit.state,
          ).thenReturn(UserStatsInitial());
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(AppRoutes.userStats);
          await widgetTester.pumpAndSettle();
          expect(find.byType(UserStatsPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Ranking page',
    () {
      late MockRankingPageCubit mockRankingPageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockRankingPageCubit = MockRankingPageCubit();
          locator.registerFactory<RankingPageCubit>(
            () => mockRankingPageCubit,
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
        'Should route to ranking page',
        (widgetTester) async {
          when(
            () => mockRankingPageCubit.state,
          ).thenReturn(RankingPageInitial());
          when(() => mockRankingPageCubit.loadData(any())).thenAnswer(
            (_) async {},
          );
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator = widgetTester.state(
            find.byType(Navigator),
          );
          navigator.pushNamed(
            AppRoutes.ranking,
            arguments: RankingPageArguments(challengeId: 3),
          );
          await widgetTester.pumpAndSettle();
          expect(find.byType(RankingPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'New check in page',
    () {
      late MockNewCheckInPageCubit mockNewCheckInPageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockNewCheckInPageCubit = MockNewCheckInPageCubit();
          locator.registerFactory<NewCheckInPageCubit>(
            () => mockNewCheckInPageCubit,
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
        'Should route to new check in page',
        (widgetTester) async {
          when(
            () => mockNewCheckInPageCubit.state,
          ).thenReturn(
            NewCheckInPageState(
              status: NewCheckInPageStatus.idle,
              photo: null,
              title: '',
              description: '',
            ),
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
            AppRoutes.newCheckIn,
            arguments: NewCheckInPageArguments(
              challengeId: 2,
              photo: XFile('any'),
            ),
          );
          await widgetTester.pumpAndSettle();
          expect(find.byType(NewCheckInPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Gym challenge details page',
    () {
      late MockGymChallengeDetailsPageCubit mockGymChallengeDetailsPageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockGymChallengeDetailsPageCubit = MockGymChallengeDetailsPageCubit();
          locator.registerFactory<GymChallengeDetailsPageCubit>(
            () => mockGymChallengeDetailsPageCubit,
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
        'Should route to gym challenge details page',
        (widgetTester) async {
          when(
            () => mockGymChallengeDetailsPageCubit.state,
          ).thenReturn(GymChallengeDetailsPageInitial());
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator = widgetTester.state(
            find.byType(Navigator),
          );
          navigator.pushNamed(
            AppRoutes.gymChallengeDetails,
            arguments: GymChallengePageArguments(challengeId: 2),
          );
          await widgetTester.pumpAndSettle();
          expect(find.byType(GymChallengeDetailsPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Home page',
    () {
      late MockHomePageCubit mockHomePageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockHomePageCubit = MockHomePageCubit();
          locator.registerFactory<HomePageCubit>(
            () => mockHomePageCubit,
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
        'Should route to home page',
        (widgetTester) async {
          when(
            () => mockHomePageCubit.state,
          ).thenReturn(HomePageDataInitial());
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(AppRoutes.home);
          await widgetTester.pumpAndSettle();
          expect(find.byType(HomePage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Sign in page',
    () {
      late MockSignInPageBloc mockSignInPageBloc;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockSignInPageBloc = MockSignInPageBloc();
          locator.registerFactory<SignInPageBloc>(
            () => mockSignInPageBloc,
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
        'Should route to sign in page',
        (widgetTester) async {
          when(
            () => mockSignInPageBloc.state,
          ).thenReturn(
            SignInPageState.empty(),
          );
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(AppRoutes.signin);
          await widgetTester.pumpAndSettle();
          expect(find.byType(SignInPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Create account page',
    () {
      //late MockSignInPageBloc mockSignInPageBloc;
      late MockCreateAccountPageCubit mockCreateAccountPageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockCreateAccountPageCubit = MockCreateAccountPageCubit();
          locator.registerFactory<CreateAccountPageCubit>(
            () => mockCreateAccountPageCubit,
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
        'Should route to sign in page',
        (widgetTester) async {
          when(
            () => mockCreateAccountPageCubit.state,
          ).thenReturn(
            CreateAccountPageState.empty(),
          );
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(AppRoutes.createAccount);
          await widgetTester.pumpAndSettle();
          expect(find.byType(CreateAccountPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Edit check in',
    () {
      //late MockCreateAccountPageCubit mockCreateAccountPageCubit;
      late MockEditCheckInPageCubit mockEditCheckInPageCubit;
      late MockAppDrawerCubit mockAppDrawerCubit;
      setUp(
        () {
          mockAppDrawerCubit = MockAppDrawerCubit();
          mockEditCheckInPageCubit = MockEditCheckInPageCubit();
          locator.registerFactory<EditCheckInPageCubit>(
            () => mockEditCheckInPageCubit,
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
        'Should route to edit check in page',
        (widgetTester) async {
          when(
            () => mockEditCheckInPageCubit.state,
          ).thenReturn(EditCheckInPageState(
            imageUrl: '',
            errorMessage: '',
            title: '',
            status: EditCheckInPageStatus.idle,
          ));
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(
            AppRoutes.editCheckin,
            arguments: EditCheckInPageArguments(
              exerciseLog: ExerciseLog(
                id: 1,
                title: '',
                date: DateTime(2025),
                userId: 1,
                gymChallengeId: 99,
              ),
            ),
          );
          await widgetTester.pumpAndSettle();
          expect(find.byType(EditCheckInPage), findsOneWidget);
        },
      );
    },
  );
  group(
    'Welcome',
    () {
      testWidgets(
        'Should route to welcome page',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: AppRoutes.serverDown,
              onGenerateRoute: AppRouter.ongenerateRoute,
            ),
          );
          final NavigatorState navigator =
              widgetTester.state(find.byType(Navigator));
          navigator.pushNamed(
            AppRoutes.welcome,
          );
          await widgetTester.pumpAndSettle();
          expect(find.byType(WelcomePage), findsOneWidget);
        },
      );
    },
  );
  // group(
  //   'Splash',
  //   () {
  //     late MockAuthCubit mockAuthCubit;
  //     setUp(
  //       () {
  //         mockAuthCubit = MockAuthCubit();
  //         locator.registerFactory<AuthCubit>(
  //           () => mockAuthCubit,
  //         );
  //       },
  //     );
  //     tearDown(
  //       () async {
  //         await locator.reset();
  //       },
  //     );
  //     testWidgets(
  //       'Should navigate to welcome page if user is unauthenticaded',
  //       (widgetTester) async {
  //         whenListen(
  //             mockAuthCubit,
  //             Stream<AuthState>.fromIterable([
  //               AuthState(
  //                 authStatus: AuthStatus.unauthenticated,
  //                 failed: false,
  //               )
  //             ]));
  //         await widgetTester.pumpWidget(
  //           BlocProvider.value(
  //             value: mockAuthCubit,
  //             child: MaterialApp(
  //               initialRoute: AppRouter.initialRoute,
  //               onGenerateRoute: AppRouter.ongenerateRoute,
  //             ),
  //           ),
  //         );
  //         await widgetTester.pumpAndSettle();
  //         expect(find.byType(WelcomePage), findsOneWidget);
  //       },
  //     );
  //   },
  // );
}
