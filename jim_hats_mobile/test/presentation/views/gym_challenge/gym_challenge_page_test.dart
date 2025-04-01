import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_page/gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/widgets/challenge_banner.dart';
import 'package:jim_hats_mobile/presentation/widgets/exercise_log_tile/exercise_log_tile.dart';
import 'package:jim_hats_mobile/presentation/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockAppDrawerCubit extends MockCubit<AppDrawerState>
    implements AppDrawerCubit {}

class MockGymChallengePageCubit extends MockCubit<GymChallengePageState>
    implements GymChallengePageCubit {}

void main() {
  final sampleLeader = Ranking(id: 2, username: 'Leader', logCount: 200);
  final sampleUserRanking = Ranking(id: 3, username: 'User', logCount: 132);
  final sampleChallenge = GymChallenge(
    id: 4,
    name: 'June Challenge',
    description: '30 days of june',
    createdAt: DateTime(2025),
    startAt: DateTime(2025, 6),
    endAt: DateTime(2025, 7),
    creatorId: 3,
  );
  final sampleLogsGroupedByDate = {
    '05/03/2025': [
      ExerciseLogWithUser(
        user: User(username: 'user1'),
        id: 1,
        title: 'Challenge title',
        date: DateTime(2025, 3, 5),
        userId: 9,
        gymChallengeId: 4,
      )
    ]
  };
  late MockAppDrawerCubit mockAppDrawerCubit;
  late MockGymChallengePageCubit mockGymChallengePageCubit;
  setUp(
    () {
      mockGymChallengePageCubit = MockGymChallengePageCubit();
      mockAppDrawerCubit = MockAppDrawerCubit();
      locator.registerFactory<GymChallengePageCubit>(
        () => mockGymChallengePageCubit,
      );
      locator.registerFactory<AppDrawerCubit>(
        () => mockAppDrawerCubit,
      );
    },
  );
  tearDown(
    () {
      locator.unregister<GymChallengePageCubit>();
      locator.unregister<AppDrawerCubit>();
    },
  );
  testWidgets('Should display empty initial data', (tester) async {
    when(
      () => mockGymChallengePageCubit.state,
    ).thenReturn(
      GymChallengePageInitial(),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: GymChallengePage(
          gymChallengePageArguments: GymChallengePageArguments(challengeId: 1),
        ),
      ),
    );
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byKey(GymChallengeView.emptySizedBoxAppBarKey), findsOneWidget);
    expect(find.byKey(GymChallengeView.emptySizedBoxBody), findsOneWidget);
  });
  testWidgets(
      'Should display loading circular progress indicator when page content is loading',
      (tester) async {
    when(
      () => mockGymChallengePageCubit.state,
    ).thenReturn(
      GymChallengePageDataLoadInProgress(),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: GymChallengePage(
          gymChallengePageArguments: GymChallengePageArguments(challengeId: 1),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsAny);
  });
  testWidgets('Should display error message when load page data fails',
      (tester) async {
    final errorMsg = 'ERROR LOADING PAGE DATA';
    when(
      () => mockGymChallengePageCubit.state,
    ).thenReturn(
      GymChallengePageDataLoadFailure(message: errorMsg),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: GymChallengePage(
          gymChallengePageArguments: GymChallengePageArguments(challengeId: 1),
        ),
      ),
    );

    expect(find.text(errorMsg), findsOne);
  });
  testWidgets('Should display page data', (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockGymChallengePageCubit.state,
        ).thenReturn(
          GymChallengePageDataSuccess(
            challenge: sampleChallenge,
            leader: sampleLeader,
            userRanking: sampleUserRanking,
            logs: [],
            logsGroupedByDate: sampleLogsGroupedByDate,
          ),
        );
        await tester.pumpWidget(
          MaterialApp(
            home: GymChallengePage(
              gymChallengePageArguments:
                  GymChallengePageArguments(challengeId: 1),
            ),
          ),
        );
        expect(find.text(sampleChallenge.name), findsOne);
      },
    );
  });
  testWidgets('Should navigate to details page', (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockGymChallengePageCubit.state,
        ).thenReturn(
          GymChallengePageDataSuccess(
            challenge: sampleChallenge,
            leader: sampleLeader,
            userRanking: sampleUserRanking,
            logs: [],
            logsGroupedByDate: sampleLogsGroupedByDate,
          ),
        );
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              AppRoutes.gymChallengeDetails: (context) => Scaffold(
                    body: Text(
                      AppRoutes.gymChallengeDetails,
                    ),
                  )
            },
            home: GymChallengePage(
              gymChallengePageArguments:
                  GymChallengePageArguments(challengeId: 1),
            ),
          ),
        );
        await tester.tap(find.byIcon(Icons.book));
        await tester.pumpAndSettle();

        expect(find.text(AppRoutes.gymChallengeDetails), findsOne);
      },
    );
  });
  testWidgets('Should navigate to ranking page', (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockGymChallengePageCubit.state,
        ).thenReturn(
          GymChallengePageDataSuccess(
            challenge: sampleChallenge,
            leader: sampleLeader,
            userRanking: sampleUserRanking,
            logs: [],
            logsGroupedByDate: sampleLogsGroupedByDate,
          ),
        );
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              AppRoutes.ranking: (context) => Scaffold(
                    body: Text(
                      AppRoutes.ranking,
                    ),
                  )
            },
            home: GymChallengePage(
              gymChallengePageArguments:
                  GymChallengePageArguments(challengeId: 1),
            ),
          ),
        );
        await tester.tap(find.byIcon(Icons.list));
        await tester.pumpAndSettle();

        expect(find.text(AppRoutes.ranking), findsOne);
      },
    );
  });
  testWidgets(
      'Should navigate to ranking page when clicking on challenge banner',
      (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockGymChallengePageCubit.state,
        ).thenReturn(
          GymChallengePageDataSuccess(
            challenge: sampleChallenge,
            leader: sampleLeader,
            userRanking: sampleUserRanking,
            logs: [],
            logsGroupedByDate: sampleLogsGroupedByDate,
          ),
        );
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              AppRoutes.ranking: (context) => Scaffold(
                    body: Text(
                      AppRoutes.ranking,
                    ),
                  )
            },
            home: GymChallengePage(
              gymChallengePageArguments:
                  GymChallengePageArguments(challengeId: 1),
            ),
          ),
        );
        await tester.tap(find.byType(ChallengeBanner));
        await tester.pumpAndSettle();

        expect(find.text(AppRoutes.ranking), findsOne);
      },
    );
  });
  testWidgets(
      'Should display take photo widget when clickin on Floating action button',
      (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockGymChallengePageCubit.state,
        ).thenReturn(
          GymChallengePageDataSuccess(
            challenge: sampleChallenge,
            leader: sampleLeader,
            userRanking: sampleUserRanking,
            logs: [],
            logsGroupedByDate: sampleLogsGroupedByDate,
          ),
        );
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              AppRoutes.ranking: (context) => Scaffold(
                    body: Text(
                      AppRoutes.ranking,
                    ),
                  )
            },
            home: GymChallengePage(
              gymChallengePageArguments:
                  GymChallengePageArguments(challengeId: 1),
            ),
          ),
        );
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        expect(find.byType(TakePhotoWidget), findsOneWidget);
        //expect(find.text(AppRoutes.ranking), findsOne);
      },
    );
  });
  testWidgets('Should navigate to edit photo page when clicking on icon button',
      (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockGymChallengePageCubit.state,
        ).thenReturn(
          GymChallengePageDataSuccess(
            challenge: sampleChallenge,
            leader: sampleLeader,
            userRanking: sampleUserRanking,
            logs: [],
            logsGroupedByDate: sampleLogsGroupedByDate,
          ),
        );
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              AppRoutes.editGymChallenge: (context) => Scaffold(
                    body: Text(
                      AppRoutes.editGymChallenge,
                    ),
                  )
            },
            home: GymChallengePage(
              gymChallengePageArguments:
                  GymChallengePageArguments(challengeId: 1),
            ),
          ),
        );
        await tester.tap(find.byIcon(Icons.more_horiz));
        await tester.pumpAndSettle();
        expect(find.text(AppRoutes.editGymChallenge), findsOne);
        //expect(find.byType(TakePhotoWidget), findsOneWidget);
        //expect(find.text(AppRoutes.ranking), findsOne);
      },
    );
  });
  testWidgets(
      'Should navigate check in page when clicking in a exercise log tile',
      (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockGymChallengePageCubit.state,
        ).thenReturn(
          GymChallengePageDataSuccess(
            challenge: sampleChallenge,
            leader: sampleLeader,
            userRanking: sampleUserRanking,
            logs: [],
            logsGroupedByDate: sampleLogsGroupedByDate,
          ),
        );
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              AppRoutes.checkIn: (context) => Scaffold(
                    body: Text(
                      AppRoutes.checkIn,
                    ),
                  )
            },
            home: GymChallengePage(
              gymChallengePageArguments:
                  GymChallengePageArguments(challengeId: 1),
            ),
          ),
        );
        await tester.tap(
          find.byKey(
            Key('GymChallengeView.exercise_log_tile_n0'),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text(AppRoutes.checkIn), findsOne);
        //expect(find.byType(TakePhotoWidget), findsOneWidget);
        //expect(find.text(AppRoutes.ranking), findsOne);
      },
    );
  });
}
