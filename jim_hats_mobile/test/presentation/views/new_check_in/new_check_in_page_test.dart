import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/new_check_in_page/new_check_in_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/new_check_in/new_check_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/new_check_in/new_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:mocktail/mocktail.dart';

class MockNewCheckInPageCubit extends MockCubit<NewCheckInPageState>
    implements NewCheckInPageCubit {}

void main() {
  late MockNewCheckInPageCubit mockNewCheckInPageCubit;
  final samplePageArguments = NewCheckInPageArguments(
    photo: XFile('any'),
    challengeId: 9,
  );
  setUp(() {
    mockNewCheckInPageCubit = MockNewCheckInPageCubit();
    locator.registerFactory<NewCheckInPageCubit>(
      () => mockNewCheckInPageCubit,
    );
  });
  tearDown(() async {
    await locator.reset();
  });
  testWidgets('Should display main form components', (tester) async {
    when(
      () => mockNewCheckInPageCubit.state,
    ).thenReturn(
      NewCheckInPageState(
          status: NewCheckInPageStatus.idle,
          photo: samplePageArguments.photo,
          title: '',
          description: ''),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NewCheckInPage(
          pageArguments: samplePageArguments,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(NewCheckInView.exerciseLogDescriptionTextFieldKey),
      findsOneWidget,
    );
    expect(
      find.byKey(NewCheckInView.postButtonKey),
      findsOneWidget,
    );
    expect(
      find.byKey(NewCheckInView.exerciseLogTitleTextFieldKey),
      findsOneWidget,
    );
  });
  testWidgets('Should display loading indicator', (tester) async {
    when(
      () => mockNewCheckInPageCubit.state,
    ).thenReturn(
      NewCheckInPageState(
        status: NewCheckInPageStatus.loading,
        photo: samplePageArguments.photo,
        title: '',
        description: '',
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NewCheckInPage(
          pageArguments: samplePageArguments,
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets(
    'Should navigate to /gym-challenge when form submission is OK',
    (widgetTester) async {
      whenListen(
        mockNewCheckInPageCubit,
        Stream.fromIterable([
          NewCheckInPageState(
            status: NewCheckInPageStatus.success,
            photo: samplePageArguments.photo,
            title: '',
            description: '',
          ),
        ]),
        initialState: NewCheckInPageState(
          status: NewCheckInPageStatus.idle,
          photo: samplePageArguments.photo,
          title: '',
          description: '',
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.gymChallenge: (context) => const Scaffold(
                  body: Text(
                    AppRoutes.gymChallenge,
                  ),
                ),
          },
          home: NewCheckInPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );
      await widgetTester.enterText(
          find.byKey(NewCheckInView.exerciseLogTitleTextFieldKey), 'title');
      await widgetTester.enterText(
          find.byKey(NewCheckInView.exerciseLogDescriptionTextFieldKey),
          'description');
      await widgetTester.tap(
        find.byKey(NewCheckInView.postButtonKey),
        warnIfMissed: false,
      );
      await widgetTester.pumpAndSettle();

      expect(find.text(AppRoutes.gymChallenge), findsOne);
    },
  );
  testWidgets(
    'Should display snack bar when form submission fails',
    (widgetTester) async {
      whenListen(
        mockNewCheckInPageCubit,
        Stream.fromIterable([
          NewCheckInPageState(
            status: NewCheckInPageStatus.failed,
            photo: samplePageArguments.photo,
            title: '',
            description: '',
          ),
        ]),
        initialState: NewCheckInPageState(
          status: NewCheckInPageStatus.idle,
          photo: samplePageArguments.photo,
          title: '',
          description: '',
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: NewCheckInPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );
      await widgetTester.enterText(
          find.byKey(NewCheckInView.exerciseLogTitleTextFieldKey), 'title');
      await widgetTester.enterText(
          find.byKey(NewCheckInView.exerciseLogDescriptionTextFieldKey),
          'description');
      await widgetTester.tap(
        find.byKey(NewCheckInView.postButtonKey),
        warnIfMissed: false,
      );
      await widgetTester.pumpAndSettle();

      expect(
        find.byType(SnackBar),
        findsOneWidget,
      );
    },
  );
  testWidgets(
    'Should display add photo btn when photo is null',
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
          home: NewCheckInPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      expect(
        find.text('Add a Photo'),
        findsOneWidget,
      );
    },
  );
  testWidgets(
    'Should display modal when media inkwell is clicked',
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
          home: NewCheckInPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(
        find.byKey(NewCheckInView.mediaCardInkwellKey),
      );
      await widgetTester.pumpAndSettle();
      expect(find.text('Photo Selection'), findsOne);
    },
  );
  testWidgets(
    'Should display Take picture widget when clicking on Update Photo btn',
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
          home: NewCheckInPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(
        find.byKey(NewCheckInView.mediaCardInkwellKey),
      );
      await widgetTester.pumpAndSettle();
      //Update photo
      await widgetTester.tap(
        find.text('Update photo'),
      );
      await widgetTester.pumpAndSettle();
      expect(find.byType(TakePhotoWidget), findsOneWidget);
    },
  );
}
