import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_challenge_page/create_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/create-chalenge/create_challenge_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

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
    when(() => mockCreateChallengePageCubit.getDayCount(
        DateTime(2025), DateTime(2025))).thenReturn(999);

    await tester.pumpWidget(
      MaterialApp(
        home: CreateChallengePage(),
      ),
    );

    expect(
        find.byKey(CreateChallengeView.createChallengeBtnKey), findsOneWidget);
    expect(find.byKey(CreateChallengeView.nameTextFieldKey), findsOneWidget);
    expect(find.byKey(CreateChallengeView.descriptionTextFieldKey),
        findsOneWidget);
    expect(find.byKey(CreateChallengeView.startAtTextFieldKey), findsOneWidget);
  });
  testWidgets('Should display challenge image file', (tester) async {
    mockNetworkImagesFor(
      () async {
        when(() => mockCreateChallengePageCubit.state).thenReturn(
          CreateChallengePageState(
            image: XFile('any'),
            name: '',
            description: '',
            startAt: DateTime(2025),
            endAt: DateTime(2025),
            errorMessage: '',
            status: CreateChallengePageStatus.error,
          ),
        );
        when(() => mockCreateChallengePageCubit.formatDate(DateTime(2025)))
            .thenReturn('01/01/2025');
        when(() => mockCreateChallengePageCubit.getDayCount(
            DateTime(2025), DateTime(2025))).thenReturn(999);

        await tester.pumpWidget(
          MaterialApp(
            home: CreateChallengePage(),
          ),
        );
        expect(find.byKey(CreateChallengeView.imageInkKey), findsOneWidget);
      },
    );
  });
  testWidgets('Should display error snackbar when form submission fails',
      (tester) async {
    final errorMsg = 'ERROR CREATING CHALLENGE';
    whenListen(
        mockCreateChallengePageCubit,
        Stream<CreateChallengePageState>.fromIterable([
          CreateChallengePageState(
            startAt: DateTime(2025),
            endAt: DateTime(2025),
            status: CreateChallengePageStatus.error,
            name: '',
            description: '',
            errorMessage: errorMsg,
          )
        ]),
        initialState: CreateChallengePageState(
          startAt: DateTime(2025),
          endAt: DateTime(2025),
          status: CreateChallengePageStatus.idle,
          name: '',
          description: '',
          errorMessage: '',
        ));
    when(() => mockCreateChallengePageCubit.formatDate(DateTime(2025)))
        .thenReturn('01/01/2025');
    when(() => mockCreateChallengePageCubit.getDayCount(
        DateTime(2025), DateTime(2025))).thenReturn(999);
    await tester.pumpWidget(
      MaterialApp(
        home: CreateChallengePage(),
      ),
    );
    await tester.enterText(
      find.byKey(CreateChallengeView.nameTextFieldKey),
      'generic name',
    );
    await tester.enterText(
      find.byKey(CreateChallengeView.descriptionTextFieldKey),
      'generic description',
    );
    await tester.tap(find.byKey(CreateChallengeView.startAtTextFieldKey));
    final NavigatorState navigator = tester.state(find.byType(Navigator));
    navigator.pop();
    await tester.pump();
    await tester.tap(find.byKey(CreateChallengeView.createChallengeBtnKey));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(errorMsg), findsOne);
  });
  testWidgets('Should display circular progress indicator in loading state',
      (tester) async {
    whenListen(
        mockCreateChallengePageCubit,
        Stream<CreateChallengePageState>.fromIterable([
          CreateChallengePageState(
            startAt: DateTime(2025),
            endAt: DateTime(2025),
            status: CreateChallengePageStatus.idle,
            name: 'generic name',
            description: '',
            errorMessage: '',
          ),
          CreateChallengePageState(
            startAt: DateTime(2025),
            endAt: DateTime(2025),
            status: CreateChallengePageStatus.loading,
            name: '',
            description: '',
            errorMessage: '',
          )
        ]),
        initialState: CreateChallengePageState(
          startAt: DateTime(2025),
          endAt: DateTime(2025),
          status: CreateChallengePageStatus.idle,
          name: '',
          description: '',
          errorMessage: '',
        ));
    when(() => mockCreateChallengePageCubit.formatDate(DateTime(2025)))
        .thenReturn('01/01/2025');
    when(() => mockCreateChallengePageCubit.getDayCount(
        DateTime(2025), DateTime(2025))).thenReturn(999);
    await tester.pumpWidget(
      MaterialApp(
        home: CreateChallengePage(),
      ),
    );
    await tester.enterText(
      find.byKey(CreateChallengeView.nameTextFieldKey),
      'generic name',
    );
    // await tester.enterText(
    //   find.byKey(CreateChallengeView.descriptionTextFieldKey),
    //   'generic description',
    // );
    //await tester.tap(find.byKey(CreateChallengeView.createChallengeBtnKey));
    //  await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsAny);
  });
  testWidgets('Should tap create challenge btn', (tester) async {
    whenListen(mockCreateChallengePageCubit,
        Stream<CreateChallengePageState>.fromIterable([]),
        initialState: CreateChallengePageState(
          startAt: DateTime(2025),
          endAt: DateTime(2025),
          status: CreateChallengePageStatus.idle,
          name: '',
          description: '',
          errorMessage: '',
        ));
    when(() => mockCreateChallengePageCubit.formatDate(DateTime(2025)))
        .thenReturn('01/01/2025');
    when(() => mockCreateChallengePageCubit.getDayCount(
        DateTime(2025), DateTime(2025))).thenReturn(999);
    await tester.pumpWidget(
      MaterialApp(
        home: CreateChallengePage(),
      ),
    );

    // await tester.enterText(
    //   find.byKey(CreateChallengeView.descriptionTextFieldKey),
    //   'generic description',
    // );
    await tester.tap(find.byKey(CreateChallengeView.createChallengeBtnKey));
    await tester.pump();
    //expect(find.text('Title is required'), findsOne);
    //expect(find.byType(CircularProgressIndicator), findsAny);
  });
  testWidgets('Should display menu options when image is clicked',
      (tester) async {
    whenListen(mockCreateChallengePageCubit,
        Stream<CreateChallengePageState>.fromIterable([]),
        initialState: CreateChallengePageState(
            startAt: DateTime(2025),
            endAt: DateTime(2025),
            status: CreateChallengePageStatus.idle,
            name: '',
            description: '',
            errorMessage: '',
            image: XFile('any')));
    when(() => mockCreateChallengePageCubit.formatDate(DateTime(2025)))
        .thenReturn('01/01/2025');
    when(() => mockCreateChallengePageCubit.getDayCount(
        DateTime(2025), DateTime(2025))).thenReturn(999);
    await tester.pumpWidget(
      MaterialApp(
        home: CreateChallengePage(),
      ),
    );

    await tester.tap(
      find.byKey(CreateChallengeView.imageInkKey),
      warnIfMissed: false,
    );
    await tester.pumpAndSettle();
    expect(find.byType(PopupMenuItem), findsAny);
  });
}
