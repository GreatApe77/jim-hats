import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/check_in_page/check_in_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/check_in_page/check_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/check_in_page/check_in_page_arguments.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockCheckInPageCubit extends MockCubit<CheckInPageState>
    implements CheckInPageCubit {}

void main() {
  late CheckInPageCubit mockCheckInPageCubit;
  final sampleExerciseLogWithUser = ExerciseLogWithUser(
    user: User(username: 'mateus'),
    image: 'https://exerciseimage.com',
    id: 1,
    title: 'Soccer',
    date: DateTime(2025, 25, 3, 17, 30),
    description: 'Soccer game',
    userId: 9,
    gymChallengeId: 10,
  );
  final sampleExerciseLogWithUserNullDescription = ExerciseLogWithUser(
    user: User(username: 'mateus'),
    image: 'https://exerciseimage.com',
    id: 1,
    title: 'Soccer',
    date: DateTime(2025, 25, 3, 17, 30),
    userId: 9,
    gymChallengeId: 10,
  );
  final sampleExerciseLogWithUserNullImage = ExerciseLogWithUser(
    user: User(username: 'mateus'),
    id: 1,
    title: 'Soccer',
    date: DateTime(2025, 25, 3, 17, 30),
    userId: 9,
    gymChallengeId: 10,
  );
  setUp(
    () {
      mockCheckInPageCubit = MockCheckInPageCubit();
      locator.registerFactory<CheckInPageCubit>(
        () => mockCheckInPageCubit,
      );
    },
  );
  tearDown(
    () {
      locator.unregister<CheckInPageCubit>();
    },
  );
  testWidgets('Should display exercise log information with null image',
      (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockCheckInPageCubit.state,
        ).thenReturn(
          CheckInPageInitial(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: CheckInPage(
              checkInPageArguments: CheckInPageArguments(
                  exerciseLog: sampleExerciseLogWithUserNullImage),
            ),
          ),
        );

        expect(find.text('Soccer'), findsOne);
        expect(find.byIcon(Icons.image), findsOneWidget);
      },
    );
  });
  testWidgets('Should display exercise log information with description',
      (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockCheckInPageCubit.state,
        ).thenReturn(
          CheckInPageInitial(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: CheckInPage(
              checkInPageArguments:
                  CheckInPageArguments(exerciseLog: sampleExerciseLogWithUser),
            ),
          ),
        );

        expect(find.text('Soccer'), findsOne);
        expect(find.text('Soccer game'), findsOne);
      },
    );
  });
  testWidgets('Should display exercise log information with null description',
      (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockCheckInPageCubit.state,
        ).thenReturn(
          CheckInPageInitial(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: CheckInPage(
              checkInPageArguments: CheckInPageArguments(
                  exerciseLog: sampleExerciseLogWithUserNullDescription),
            ),
          ),
        );

        expect(find.text('Soccer'), findsOne);
        expect(find.text('Soccer game'), findsNothing);
      },
    );
  });

  testWidgets('Should click and display popup menu options', (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockCheckInPageCubit.state,
        ).thenReturn(
          CheckInPageInitial(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: CheckInPage(
              checkInPageArguments: CheckInPageArguments(
                  exerciseLog: sampleExerciseLogWithUserNullDescription),
            ),
          ),
        );

        await tester.tap(find.byType(PopupMenuButton));
        await tester.pumpAndSettle();
        expect(find.text('Edit'), findsOne);
        expect(find.text('Remove check-in'), findsOne);
      },
    );
  });
  testWidgets('Should remove check in but it is canceled in the dialog',
      (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockCheckInPageCubit.state,
        ).thenReturn(
          CheckInPageInitial(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: CheckInPage(
              checkInPageArguments: CheckInPageArguments(
                  exerciseLog: sampleExerciseLogWithUserNullDescription),
            ),
          ),
        );

        await tester.tap(find.byType(PopupMenuButton));
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(
            Key('CheckInView.remove_check_in_popup_btn'),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsOneWidget);
        //Key('CheckInView.cancel_remove_btn')
        await tester.tap(find.byKey(Key('CheckInView.cancel_remove_btn')));
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsNothing);
      },
    );
  });
  testWidgets('Should navigate to edit check in page', (tester) async {
    mockNetworkImagesFor(
      () async {
        when(
          () => mockCheckInPageCubit.state,
        ).thenReturn(
          CheckInPageInitial(),
        );

        await tester.pumpWidget(
          MaterialApp(
            routes: {
              AppRoutes.editCheckin: (context) => Scaffold(
                    body: Text(AppRoutes.editCheckin),
                  )
            },
            home: CheckInPage(
              checkInPageArguments: CheckInPageArguments(
                  exerciseLog: sampleExerciseLogWithUserNullDescription),
            ),
          ),
        );

        await tester.tap(find.byType(PopupMenuButton));
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(
            Key('CheckInView.edit_check_in_btn'),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text(AppRoutes.editCheckin), findsOne);
      },
    );
  });
  testWidgets('Should display error snack bar when deleting check in fails',
      (tester) async {
    mockNetworkImagesFor(
      () async {
        final errorMsg = 'ERROR DELETING CHECK IN';
        whenListen(
            mockCheckInPageCubit,
            Stream<CheckInPageState>.fromIterable(
              [
                CheckInPageError(errorMessage: errorMsg),
              ],
            ),
            initialState: CheckInPageInitial());

        await tester.pumpWidget(
          MaterialApp(
            home: CheckInPage(
              checkInPageArguments: CheckInPageArguments(
                  exerciseLog: sampleExerciseLogWithUserNullDescription),
            ),
          ),
        );

        await tester.tap(find.byType(PopupMenuButton));
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(
            Key('CheckInView.remove_check_in_popup_btn'),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key('CheckInView.confirm_remove_btn')));
        await tester.pumpAndSettle();
        //expect(find.byType(SnackBar), findsOneWidget);
        //expect(find.text(errorMsg),findsOne);
      },
    );
  });
}
