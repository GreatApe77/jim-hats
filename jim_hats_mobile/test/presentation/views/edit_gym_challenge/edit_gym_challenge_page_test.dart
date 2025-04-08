import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/edit_gym_challenge_page/edit_gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page_arguments.dart';
import 'package:mocktail/mocktail.dart';

class MockEditGymChallengePageCubit extends MockCubit<EditGymChallengePageState>
    implements EditGymChallengePageCubit {}

void main() {
  late MockEditGymChallengePageCubit mockEditGymChallengePageCubit;
  final sampleInitialState = EditGymChallengePageState(
    status: EditGymChallengePageStatus.idle,
    imageUrl: '',
    name: '',
    description: '',
    image: null,
    startAt: DateTime(2025),
    endAt: DateTime(2025),
    errorMessage: '',
  );
  final sampleEditGymChallengePageArguments = EditGymChallengePageArguments(
      gymChallenge: GymChallenge(
          id: 1,
          name: 'name',
          description: 'description',
          createdAt: DateTime(2025),
          startAt: DateTime(
            2025,
          ),
          endAt: DateTime(2025),
          creatorId: 99));
  setUp(
    () {
      mockEditGymChallengePageCubit = MockEditGymChallengePageCubit();
      locator.registerFactory<EditGymChallengePageCubit>(
        () => mockEditGymChallengePageCubit,
      );
    },
  );
  tearDown(
    () async {
      await locator.reset();
    },
  );
  testWidgets(
    'Should display main form components',
    (widgetTester) async {
      when(
        () => mockEditGymChallengePageCubit.state,
      ).thenReturn(sampleInitialState);
      await widgetTester.pumpWidget(
        MaterialApp(
          home: EditGymChallengePage(
            editGymChallengePageArguments: sampleEditGymChallengePageArguments,
          ),
        ),
      );
      expect(
        find.byKey(EditGymChallengeView.challengeDescriptionTextFieldKey),
        findsOneWidget,
      );
      expect(
        find.byKey(EditGymChallengeView.challengeNameTextFieldKey),
        findsOneWidget,
      );
      expect(
        find.byKey(EditGymChallengeView.startDateTextFieldKey),
        findsOneWidget,
      );
    },
  );
  testWidgets(
    'Should write in form fields',
    (widgetTester) async {
      whenListen(
        mockEditGymChallengePageCubit,
        Stream<EditGymChallengePageState>.fromIterable([]),
        initialState: sampleInitialState,
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: EditGymChallengePage(
            editGymChallengePageArguments: sampleEditGymChallengePageArguments,
          ),
        ),
      );
      await widgetTester.enterText(
        find.byKey(EditGymChallengeView.challengeNameTextFieldKey),
        'sample name',
      );
      await widgetTester.enterText(
        find.byKey(EditGymChallengeView.challengeDescriptionTextFieldKey),
        'sample description',
      );
      await widgetTester.tap(
        find.byKey(
          EditGymChallengeView.startDateTextFieldKey,
        ),
      );
      await widgetTester.pumpAndSettle();
      NavigatorState navigatorState =
          widgetTester.state(find.byType(Navigator));
      navigatorState.pop();
    },
  );
}
