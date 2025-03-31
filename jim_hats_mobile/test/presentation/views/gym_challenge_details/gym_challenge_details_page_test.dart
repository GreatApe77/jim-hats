import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/challenge_member.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_details_page/gym_challenge_details_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge_details/gym_challenge_details_page.dart';
import 'package:jim_hats_mobile/presentation/widgets/user_circle_avatar/user_circle_avatar.dart';
import 'package:mocktail/mocktail.dart';

class MockGymChallengeDetailsPageCubit
    extends MockCubit<GymChallengeDetailsPageState>
    implements GymChallengeDetailsPageCubit {}

void main() {
  late MockGymChallengeDetailsPageCubit mockGymChallengeDetailsPageCubit;
  final samplePageArguments = GymChallengePageArguments(challengeId: 6);
  final sampleAdmin = ChallengeMember(id: 2, username: 'ADMIN');
  final sampleChallenge = GymChallenge(
    id: 6,
    name: 'JANUARY CHALLENGE',
    description: 'sample_description',
    createdAt: DateTime(2025, 1, 1),
    startAt: DateTime(2025, 2, 1),
    endAt: DateTime(2025, 3, 1),
    creatorId: 1,
  );
  final sampleChallengeMembers = [
    ChallengeMember(
      id: 1,
      username: 'MEMBER1',
    ),
    ChallengeMember(
      id: 2,
      username: 'MEMBER2',
    ),
  ];
  setUp(
    () {
      mockGymChallengeDetailsPageCubit = MockGymChallengeDetailsPageCubit();
      locator.registerFactory<GymChallengeDetailsPageCubit>(
        () => mockGymChallengeDetailsPageCubit,
      );
    },
  );
  tearDown(
    () {
      locator.unregister<GymChallengeDetailsPageCubit>();
    },
  );

  testWidgets(
    'Should display empty initial data',
    (widgetTester) async {
      when(() => mockGymChallengeDetailsPageCubit.state)
          .thenReturn(GymChallengeDetailsPageInitial());

      await widgetTester.pumpWidget(
        MaterialApp(
          home: GymChallengeDetailsPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );

      expect(find.byKey(GymChallengeDetailsView.shrinkedSizedBoxKey),
          findsOneWidget);
    },
  );
  testWidgets('Should display circular progress indicator when loading data',
      (widgetTester) async {
    when(
      () => mockGymChallengeDetailsPageCubit.state,
    ).thenReturn(
      GymChallengeDetailsPageLoadDataInProgress(),
    );

    await widgetTester.pumpWidget(
      MaterialApp(
        home: GymChallengeDetailsPage(
          pageArguments: samplePageArguments,
        ),
      ),
    );

    expect(
      find.byKey(GymChallengeDetailsView.loadingIndicatorKey),
      findsOneWidget,
    );
  });
  testWidgets(
    'Should display error message when loading data fails',
    (widgetTester) async {
      when(
        () => mockGymChallengeDetailsPageCubit.state,
      ).thenReturn(
        GymChallengeDetailsPageLoadError(),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: GymChallengeDetailsPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );

      expect(
        find.byKey(GymChallengeDetailsView.errorTextKey),
        findsOneWidget,
      );
    },
  );
  testWidgets(
    'Should display page data when loading data is successful',
    (widgetTester) async {
      when(
        () => mockGymChallengeDetailsPageCubit.state,
      ).thenReturn(
        GymChallengeDetailsPageLoadSuccess(
          challenge: sampleChallenge,
          members: sampleChallengeMembers,
          admin: sampleAdmin,
        ),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: GymChallengeDetailsPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );

      
      
      expect(
        find.byType(UserCircleAvatar),
        findsExactly(3),
      );
    },
  );
}
