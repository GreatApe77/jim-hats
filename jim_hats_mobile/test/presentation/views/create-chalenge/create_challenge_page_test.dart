import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_challenge_page/create_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/create-chalenge/create_challenge_page.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateChallengePageCubit extends MockCubit<CreateChallengePageState>
    implements CreateChallengePageCubit {}

void main() {
  late MockCreateChallengePageCubit mockCreateChallengePageCubit;
  setUp(() {
    mockCreateChallengePageCubit = MockCreateChallengePageCubit();
    locator.registerFactory<CreateChallengePageCubit>(
      () => mockCreateChallengePageCubit,
    );
  });
  tearDown(
    () async {
      await locator.reset();
    },
  );

  testWidgets('Should display main form components', (tester) async {
  when(() => mockCreateChallengePageCubit.state).thenReturn(
    CreateChallengePageState(
      image: null,
      name: '',
      description: '',
      startAt: DateTime(2025),
      endAt: DateTime(2025),
      errorMessage: '',
      status: CreateChallengePageStatus.idle,
    ),
  );
  when(() => mockCreateChallengePageCubit.formatDate(DateTime(2025)))
      .thenReturn('01/01/2025');
  when(() => mockCreateChallengePageCubit.getDayCount(DateTime(2025), DateTime(2025)))
      .thenReturn(999);

  await tester.pumpWidget(
    MaterialApp(
      home: CreateChallengePage(),
    ),
  );

  expect(find.byKey(CreateChallengeView.createChallengeBtnKey), findsOneWidget);
  expect(find.byKey(CreateChallengeView.nameTextFieldKey), findsOneWidget);
  expect(find.byKey(CreateChallengeView.descriptionTextFieldKey), findsOneWidget);
  expect(find.byKey(CreateChallengeView.startAtTextFieldKey), findsOneWidget);

  
});
}
