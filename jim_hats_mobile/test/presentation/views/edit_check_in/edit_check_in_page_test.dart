import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/edit_check_in_page/edit_check_in_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/edit_check_in/edit_check_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_check_in/edit_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockEditCheckInPageCubit extends MockCubit<EditCheckInPageState>
    implements EditCheckInPageCubit {}

void main() {
  late MockEditCheckInPageCubit mockEditCheckInPageCubit;
  final sampleExerciseLog = ExerciseLog(
    id: 5,
    title: 'Sample title',
    date: DateTime(2025, 3, 3),
    userId: 9,
    gymChallengeId: 10,
  );
  setUp(
    () {
      mockEditCheckInPageCubit = MockEditCheckInPageCubit();
      locator.registerFactory<EditCheckInPageCubit>(
        () => mockEditCheckInPageCubit,
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
        () => mockEditCheckInPageCubit.state,
      ).thenReturn(
        EditCheckInPageState(
          imageUrl: '',
          errorMessage: '',
          title: '',
          status: EditCheckInPageStatus.idle,
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: EditCheckInPage(
            editCheckInPageArguments:
                EditCheckInPageArguments(exerciseLog: sampleExerciseLog),
          ),
        ),
      );
      expect(find.byKey(EditCheckInView.editBtnKey), findsOneWidget);
      expect(
          find.byKey(EditCheckInView.descriptionTextFieldKey), findsOneWidget);
      expect(find.byKey(EditCheckInView.titleTextFieldKey), findsOneWidget);
    },
  );
  testWidgets(
    'Should update textfields',
    (widgetTester) async {
      final testTitle = 'exercise';
      final testDescription = 'test description for exercise';
      whenListen(
        mockEditCheckInPageCubit,
        Stream<EditCheckInPageState>.fromIterable([
          EditCheckInPageState(
            imageUrl: '',
            errorMessage: '',
            title: testTitle,
            description: testDescription,
            status: EditCheckInPageStatus.idle,
          ),
        ]),
        initialState: EditCheckInPageState(
          imageUrl: '',
          errorMessage: '',
          title: '',
          status: EditCheckInPageStatus.idle,
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: EditCheckInPage(
            editCheckInPageArguments:
                EditCheckInPageArguments(exerciseLog: sampleExerciseLog),
          ),
        ),
      );
      await widgetTester.enterText(
        find.byKey(EditCheckInView.titleTextFieldKey),
        testTitle,
      );
      await widgetTester.enterText(
        find.byKey(EditCheckInView.titleTextFieldKey),
        testDescription,
      );
    },
  );
  testWidgets(
    'Should display error snackbar',
    (widgetTester) async {
      final testErrorMessage = 'ERROR UPDATING';
      whenListen(
        mockEditCheckInPageCubit,
        Stream<EditCheckInPageState>.fromIterable([
          EditCheckInPageState(
            imageUrl: '',
            errorMessage: '',
            title: '',
            description: '',
            status: EditCheckInPageStatus.idle,
          ),
          EditCheckInPageState(
            imageUrl: '',
            errorMessage: '',
            title: '',
            description: '',
            status: EditCheckInPageStatus.idle,
          ),
          EditCheckInPageState(
            imageUrl: '',
            errorMessage: '',
            title: '',
            description: '',
            status: EditCheckInPageStatus.idle,
          ),
          EditCheckInPageState(
            imageUrl: '',
            errorMessage: testErrorMessage,
            title: '',
            description: '',
            status: EditCheckInPageStatus.error,
          ),
        ]),
        initialState: EditCheckInPageState(
          imageUrl: '',
          errorMessage: '',
          title: '',
          status: EditCheckInPageStatus.idle,
        ),
      );
      // when(
      //   () => mockEditCheckInPageCubit.state,
      // ).thenReturn(
      //   EditCheckInPageState(
      //       imageUrl: '',
      //       errorMessage: testErrorMessage,
      //       title: '',
      //       status: EditCheckInPageStatus.error),
      // );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: EditCheckInPage(
            editCheckInPageArguments:
                EditCheckInPageArguments(exerciseLog: sampleExerciseLog),
          ),
        ),
      );
      await widgetTester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(testErrorMessage), findsOne);
    },
  );
  testWidgets(
    'Should display error snackbar',
    (widgetTester) async {
      final testErrorMessage = 'ERROR UPDATING';
      whenListen(
        mockEditCheckInPageCubit,
        Stream<EditCheckInPageState>.fromIterable([
          EditCheckInPageState(
            imageUrl: '',
            errorMessage: '',
            title: '',
            status: EditCheckInPageStatus.success,
          )
        ]),
        initialState: EditCheckInPageState(
          imageUrl: '',
          errorMessage: '',
          title: '',
          status: EditCheckInPageStatus.idle,
        ),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: EditCheckInPage(
            editCheckInPageArguments:
                EditCheckInPageArguments(exerciseLog: sampleExerciseLog),
          ),
        ),
      );
      await widgetTester.enterText(
          find.byKey(EditCheckInView.titleTextFieldKey), 'EDITED TTITLE');
      await widgetTester.enterText(
          find.byKey(EditCheckInView.titleTextFieldKey), 'EDITED DESCRIPTION');
      await widgetTester.tap(
        find.byKey(
          EditCheckInView.editBtnKey,
        ),
        warnIfMissed: false,
      );
    },
  );
  testWidgets(
    'Should open TakePictureWidget when tapped on edit image btn',
    (widgetTester) async {
      whenListen(
        mockEditCheckInPageCubit,
        Stream<EditCheckInPageState>.fromIterable([]),
        initialState: EditCheckInPageState(
          imageUrl: '',
          image: null,
          errorMessage: '',
          title: '',
          status: EditCheckInPageStatus.idle,
        ),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: EditCheckInPage(
            editCheckInPageArguments:
                EditCheckInPageArguments(exerciseLog: sampleExerciseLog),
          ),
        ),
      );
      await widgetTester.tap(
        find.byKey(
          EditCheckInView.editImgBtnKey,
        ),
      );
      await widgetTester.pumpAndSettle();
      expect(
        find.byType(TakePhotoWidget),
        findsOneWidget,
      );
    },
  );
  testWidgets(
    'Should display Edit media btn when image exists',
    (widgetTester) async {
      whenListen(
        mockEditCheckInPageCubit,
        Stream<EditCheckInPageState>.fromIterable([]),
        initialState: EditCheckInPageState(
          imageUrl: '',
          image: XFile('any'),
          errorMessage: '',
          title: '',
          status: EditCheckInPageStatus.idle,
        ),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: EditCheckInPage(
            editCheckInPageArguments: EditCheckInPageArguments(
              exerciseLog: sampleExerciseLog,
            ),
          ),
        ),
      );

      //await widgetTester.pumpAndSettle();
      expect(find.text('Edit Media'), findsOne);
    },
  );
  testWidgets(
    'Should display Edit media btn when image exists (network image)',
    (widgetTester) async {
      mockNetworkImagesFor(
        () async {
          whenListen(
            mockEditCheckInPageCubit,
            Stream<EditCheckInPageState>.fromIterable([]),
            initialState: EditCheckInPageState(
              imageUrl: 'https://anyimage',
              image: null,
              errorMessage: '',
              title: '',
              status: EditCheckInPageStatus.idle,
            ),
          );

          await widgetTester.pumpWidget(
            MaterialApp(
              home: EditCheckInPage(
                editCheckInPageArguments: EditCheckInPageArguments(
                  exerciseLog: sampleExerciseLog,
                ),
              ),
            ),
          );

          //await widgetTester.pumpAndSettle();
          expect(find.text('Edit Media'), findsOne);
        },
      );
    },
  );
}
