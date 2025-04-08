import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_account_page/create_account_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/create_account/create_account_page.dart';
import 'package:jim_hats_mobile/presentation/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateAccountPageCubit extends MockCubit<CreateAccountPageState>
    implements CreateAccountPageCubit {}

void main() {
  late MockCreateAccountPageCubit mockCreateAccountPageCubit;
  setUp(
    () {
      mockCreateAccountPageCubit = MockCreateAccountPageCubit();
      locator.registerFactory<CreateAccountPageCubit>(
        () => mockCreateAccountPageCubit,
      );
    },
  );
  tearDown(
    () {
      locator.unregister<CreateAccountPageCubit>();
    },
  );

  testWidgets(
    'Should display main form components',
    (widgetTester) async {
      when(
        () => mockCreateAccountPageCubit.state,
      ).thenReturn(
        CreateAccountPageState(
            username: '',
            errorMessage: '',
            email: '',
            password: '',
            confirmPassword: '',
            image: null,
            status: Status.writingForm),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: CreateAccountPage(),
        ),
      );
      expect(
        find.byKey(CreateAccountView.usernameTextFieldKey),
        findsOneWidget,
      );
      expect(
        find.byKey(CreateAccountView.confirmPasswordTextFieldKey),
        findsOneWidget,
      );
      expect(
        find.byKey(CreateAccountView.passwordTextFieldKey),
        findsOneWidget,
      );
      expect(
        find.byKey(CreateAccountView.emailTextFieldKey),
        findsOneWidget,
      );
      expect(
        find.byKey(CreateAccountView.createAccountBtnKey),
        findsOneWidget,
      );
    },
  );
  testWidgets(
    'Should not submit form with invalid values',
    (widgetTester) async {
      when(
        () => mockCreateAccountPageCubit.state,
      ).thenReturn(
        CreateAccountPageState(
          username: '',
          errorMessage: '',
          email: '',
          password: '',
          confirmPassword: '',
          image: null,
          status: Status.writingForm,
        ),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: CreateAccountPage(),
        ),
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.usernameTextFieldKey),
        's',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.emailTextFieldKey),
        'notEmail',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.passwordTextFieldKey),
        'short',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.confirmPasswordTextFieldKey),
        'a',
      );
      //await widgetTester.enterText(find.byKey(CreateAccountView.passwordTextFieldKey), 'short');
      await widgetTester.tap(
        find.byKey(CreateAccountView.createAccountBtnKey),
      );
      await widgetTester.pump();
      expect(find.text('Please enter a valid email'), findsOne);
    },
  );
  testWidgets(
    'Create account btn should be in loading state',
    (widgetTester) async {
      whenListen(
        mockCreateAccountPageCubit,
        Stream<CreateAccountPageState>.fromIterable(
          [
            CreateAccountPageState(
              username: '',
              errorMessage: '',
              email: '',
              password: '',
              confirmPassword: '',
              image: null,
              status: Status.loading,
            ),
          ],
        ),
        initialState: CreateAccountPageState(
          username: '',
          errorMessage: '',
          email: '',
          password: '',
          confirmPassword: '',
          image: null,
          status: Status.writingForm,
        ),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: CreateAccountPage(),
        ),
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.usernameTextFieldKey),
        'username',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.emailTextFieldKey),
        'email@email.com',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.passwordTextFieldKey),
        'valid12345',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.confirmPasswordTextFieldKey),
        'valid12345',
      );
      //await widgetTester.enterText(find.byKey(CreateAccountView.passwordTextFieldKey), 'short');
      await widgetTester.tap(
        find.byKey(CreateAccountView.createAccountBtnKey),
      );
      await widgetTester.pump();
      expect(find.text('Creating...'), findsOne);
      //expect(find.text('Please enter a valid email'), findsOne);
    },
  );
  testWidgets(
    'Should submit form successfully and navigate to sign in page',
    (widgetTester) async {
      whenListen(
        mockCreateAccountPageCubit,
        Stream<CreateAccountPageState>.fromIterable(
          [
            CreateAccountPageState(
              username: '',
              errorMessage: '',
              email: '',
              password: '',
              confirmPassword: '',
              image: null,
              status: Status.success,
            ),
          ],
        ),
        initialState: CreateAccountPageState(
          username: '',
          errorMessage: '',
          email: '',
          password: '',
          confirmPassword: '',
          image: null,
          status: Status.writingForm,
        ),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.signin: (context) => Scaffold(
                  body: Text(
                    AppRoutes.signin,
                  ),
                )
          },
          home: CreateAccountPage(),
        ),
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.usernameTextFieldKey),
        'username',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.emailTextFieldKey),
        'email@email.com',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.passwordTextFieldKey),
        'valid12345',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.confirmPasswordTextFieldKey),
        'valid12345',
      );
      //await widgetTester.enterText(find.byKey(CreateAccountView.passwordTextFieldKey), 'short');
      await widgetTester.tap(
        find.byKey(
          CreateAccountView.createAccountBtnKey,
        ),
        warnIfMissed: false,
      );
      await widgetTester.pumpAndSettle();
      expect(find.text(AppRoutes.signin), findsOne);
      //expect(find.text('Please enter a valid email'), findsOne);
    },
  );
  testWidgets(
    'Should display a snackbar containing a error message if submiting fails',
    (widgetTester) async {
      final errorMsg = 'SUBMIT FAILED!';
      whenListen(
        mockCreateAccountPageCubit,
        Stream<CreateAccountPageState>.fromIterable(
          [
            CreateAccountPageState(
              username: '',
              errorMessage: errorMsg,
              email: '',
              password: '',
              confirmPassword: '',
              image: null,
              status: Status.error,
            ),
          ],
        ),
        initialState: CreateAccountPageState(
          username: '',
          errorMessage: '',
          email: '',
          password: '',
          confirmPassword: '',
          image: null,
          status: Status.writingForm,
        ),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.signin: (context) => Scaffold(
                  body: Text(
                    AppRoutes.signin,
                  ),
                )
          },
          home: CreateAccountPage(),
        ),
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.usernameTextFieldKey),
        'username',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.emailTextFieldKey),
        'email@email.com',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.passwordTextFieldKey),
        'valid12345',
      );
      await widgetTester.enterText(
        find.byKey(CreateAccountView.confirmPasswordTextFieldKey),
        'valid12345',
      );
      //await widgetTester.enterText(find.byKey(CreateAccountView.passwordTextFieldKey), 'short');
      await widgetTester.tap(
        find.byKey(
          CreateAccountView.createAccountBtnKey,
        ),
        warnIfMissed: false,
      );
      await widgetTester.pumpAndSettle();
      expect(find.text(errorMsg), findsOne);
      expect(find.byType(SnackBar), findsOneWidget);
      //expect(find.text('Please enter a valid email'), findsOne);
    },
  );
  testWidgets(
    'Should display image for profile picture',
    (widgetTester) async {
      when(
        () => mockCreateAccountPageCubit.state,
      ).thenReturn(
        CreateAccountPageState(
          username: '',
          errorMessage: '',
          email: '',
          password: '',
          confirmPassword: '',
          image: XFile('anything'),
          status: Status.writingForm,
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.signin: (context) => Scaffold(
                  body: Text(
                    AppRoutes.signin,
                  ),
                )
          },
          home: CreateAccountPage(),
        ),
      );

      expect(find.byKey(CreateAccountView.imageInkKey), findsOneWidget);
    },
  );
  testWidgets(
    'Should render a take picture widget when select image button is clicked',
    (widgetTester) async {
      when(
        () => mockCreateAccountPageCubit.state,
      ).thenReturn(
        CreateAccountPageState(
          username: '',
          errorMessage: '',
          email: '',
          password: '',
          confirmPassword: '',
          image: null,
          status: Status.writingForm,
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.signin: (context) => Scaffold(
                  body: Text(
                    AppRoutes.signin,
                  ),
                )
          },
          home: CreateAccountPage(),
        ),
      );
      await widgetTester.tap(
        find.byKey(CreateAccountView.selectImageInkWellKey),
      );
      await widgetTester.pumpAndSettle();
      expect(find.byType(TakePhotoWidget), findsOneWidget);
      //expect(find.byKey(CreateAccountView.imageInkKey), findsOneWidget);
    },
  );
  testWidgets(
    'Should render a take picture widget when change image button is clicked',
    (widgetTester) async {
      when(
        () => mockCreateAccountPageCubit.state,
      ).thenReturn(
        CreateAccountPageState(
          username: '',
          errorMessage: '',
          email: '',
          password: '',
          confirmPassword: '',
          image: XFile('anything'),
          status: Status.writingForm,
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.signin: (context) => Scaffold(
                  body: Text(
                    AppRoutes.signin,
                  ),
                )
          },
          home: CreateAccountPage(),
        ),
      );
      await widgetTester.tap(
        find.byKey(CreateAccountView.changeImageInkWellKey),
      );
      await widgetTester.pumpAndSettle();
      expect(find.byType(TakePhotoWidget), findsOneWidget);
      //expect(find.byKey(CreateAccountView.imageInkKey), findsOneWidget);
    },
  );
  testWidgets(
    'Should clear current profile picture',
    (widgetTester) async {
      whenListen(
        mockCreateAccountPageCubit,
        Stream<CreateAccountPageState>.fromIterable(
          [
            CreateAccountPageState(
              username: '',
              errorMessage: '',
              email: '',
              password: '',
              confirmPassword: '',
              image: null,
              status: Status.error,
            ),
          ],
        ),
        initialState: CreateAccountPageState(
          username: '',
          errorMessage: '',
          email: '',
          password: '',
          confirmPassword: '',
          image: XFile('any'),
          status: Status.writingForm,
        ),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.signin: (context) => Scaffold(
                  body: Text(
                    AppRoutes.signin,
                  ),
                )
          },
          home: CreateAccountPage(),
        ),
      );
      await widgetTester.tap(
        find.byKey(
          CreateAccountView.clearProfilePicBtnKey,
        ),
      );
      await widgetTester.pumpAndSettle();
      expect(find.byKey(CreateAccountView.clearProfilePicBtnKey), findsNothing);
    },
  );
  testWidgets(
    'Should toggle hide password state',
    (widgetTester) async {
      when(
        () => mockCreateAccountPageCubit.state,
      ).thenReturn(
        CreateAccountPageState(
          username: '',
          errorMessage: '',
          email: '',
          password: '',
          confirmPassword: '',
          image: null,
          status: Status.writingForm,
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.signin: (context) => Scaffold(
                  body: Text(
                    AppRoutes.signin,
                  ),
                )
          },
          home: CreateAccountPage(),
        ),
      );
      expect(find.byIcon(Icons.visibility_off), findsAny);
      await widgetTester.tap(
        find.byKey(CreateAccountView.toggleHidePasswordBtnKey),
      );
      await widgetTester.pump();
      expect(find.byIcon(Icons.visibility_off), findsNothing);
      expect(find.byIcon(Icons.visibility), findsAny);
    },
  );
}
