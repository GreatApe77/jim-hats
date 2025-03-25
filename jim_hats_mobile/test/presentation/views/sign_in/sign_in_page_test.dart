import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/blocs/sign_in_page/sign_in_page_bloc.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/sign_in/sign_in_page.dart';
import 'package:mocktail/mocktail.dart';

class _MockSignInPageBloc extends MockBloc<SignInPageEvent, SignInPageState>
    implements SignInPageBloc {}

//@GenerateNiceMocks([MockSpec<SignInPageBloc>()])
void main() {
  late _MockSignInPageBloc mockSignInPageBloc;
  final signInBtnKey = Key('SignInView.sign_in_button');
  final usernameTextFieldKey = Key('SignInView.username_field');
  final passwordTextFieldKey = Key('SignInView.password_field');
  final togglePasswordBtnKey = Key('SignInView.toggle_password_btn');
  setUp(
    () {
      mockSignInPageBloc = _MockSignInPageBloc();
      locator.registerFactory<SignInPageBloc>(
        () => mockSignInPageBloc,
      );
    },
  );
  tearDown(
    () {
      locator.unregister<SignInPageBloc>();
    },
  );

  testWidgets('Should display initial data', (tester) async {
    when(() => mockSignInPageBloc.state).thenReturn(
      SignInPageState(
          username: '',
          status: SignInPageStatus.writingForm,
          password: '',
          message: ''),
    );

    await tester.pumpWidget(MaterialApp(
      home: SignInPage(),
    ));
    final usernameTextField = find.byKey(usernameTextFieldKey);
    final passwordTextField = find.byKey(passwordTextFieldKey);
    final signInBtn = find.byKey(signInBtnKey);
    expect(usernameTextField, findsOne);
    expect(passwordTextField, findsOne);
    expect(signInBtn, findsOne);
  });
  testWidgets('Should update bloc state when typing on username form field',
      (tester) async {
    when(() => mockSignInPageBloc.state).thenReturn(
      SignInPageState(
          username: '',
          status: SignInPageStatus.writingForm,
          password: '',
          message: ''),
    );

    await tester.pumpWidget(MaterialApp(
      home: SignInPage(),
    ));
    final usernameTextField = find.byKey(usernameTextFieldKey);

    await tester.enterText(usernameTextField, 'Mateus');
    //await tester.pumpAndSettle();
    verify(
      () => mockSignInPageBloc.add(SignInUsernameChanged(username: 'Mateus')),
    ).called(1);
  });
  testWidgets('Should update bloc state when typing on password form field',
      (tester) async {
    when(
      () => mockSignInPageBloc.state,
    ).thenReturn(
      SignInPageState(
          username: '',
          status: SignInPageStatus.writingForm,
          password: '',
          message: ''),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: SignInPage(),
      ),
    );
    final passwordTextField = find.byKey(passwordTextFieldKey);

    await tester.enterText(passwordTextField, 'secret');
    await tester.pumpAndSettle();
    final typedText = find.textContaining('secret');
    expect(typedText, findsOne);
    //await tester.pumpAndSettle();
    verify(
      () => mockSignInPageBloc.add(SignInPasswordChanged(password: 'secret')),
    ).called(1);
  });
  testWidgets(
    'Should display error messages when form is submitted with empty values',
    (tester) async {
      when(
        () => mockSignInPageBloc.state,
      ).thenReturn(
        SignInPageState(
            username: '',
            status: SignInPageStatus.writingForm,
            password: '',
            message: ''),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: SignInPage(),
        ),
      );
      final signInBtn = find.byKey(signInBtnKey);
      await tester.tap(signInBtn);
      await tester.pumpAndSettle();
      final requiredUsernameErrorMessage = 'Username is required';
      final requiredPasswordErrorMessage = 'Password is required';
      expect(find.textContaining(requiredUsernameErrorMessage), findsOne);
      expect(find.textContaining(requiredPasswordErrorMessage), findsOne);
    },
  );
  testWidgets('Should display error message when sign-in fails',
      (tester) async {
    whenListen(
      mockSignInPageBloc,
      Stream<SignInPageState>.fromIterable([
        SignInPageState(
          username: '',
          status: SignInPageStatus.failure, // Simulate failure
          password: '',
          message: 'Invalid credentials',
        ),
      ]),
      initialState: SignInPageState(
        username: '',
        status: SignInPageStatus.writingForm,
        password: '',
        message: '',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: SignInPage(),
      ),
    );

    await tester.enterText(find.byKey(usernameTextFieldKey), 'valid_username');
    await tester.enterText(find.byKey(passwordTextFieldKey), 'supersecret123');

    await tester.tap(find.byKey(signInBtnKey));
    await tester.pump();

    expect(find.text('Invalid credentials'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });
  testWidgets(
    'Should toggle show/hide password',
    (widgetTester) async {
      when(
        () => mockSignInPageBloc.state,
      ).thenReturn(
        SignInPageState(
            username: '',
            status: SignInPageStatus.writingForm,
            password: '',
            message: ''),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: SignInPage(),
        ),
      );
      await widgetTester.enterText(find.byKey(passwordTextFieldKey), 'secret');
      await widgetTester.tap(find.byKey(togglePasswordBtnKey));
      await widgetTester.pump();
      expect(find.byIcon(Icons.visibility), findsOne);
      await widgetTester.tap(find.byKey(togglePasswordBtnKey));
      await widgetTester.pump();
      expect(find.byIcon(Icons.visibility_off), findsOne);
    },
  );
  testWidgets(
    'Should navigate to splash page if login is successfull',
    (widgetTester) async {
      whenListen(
        mockSignInPageBloc,
        Stream<SignInPageState>.fromIterable(
          [
            SignInPageState(
              username: 'valid_user',
              status: SignInPageStatus.loading,
              password: 'valid_pass',
              message: '',
            ),
            SignInPageState(
              username: '',
              status: SignInPageStatus.success,
              password: '',
              message: '',
            ),
          ],
        ),
        initialState: SignInPageState(
            username: '',
            status: SignInPageStatus.writingForm,
            password: '',
            message: ''),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: SignInPage(),
          routes: {
            AppRoutes.splash: (context) => Scaffold(
                  body: Text('Splash'),
                )
          },
        ),
      );
      await widgetTester.enterText(
        find.byKey(usernameTextFieldKey),
        'sample_username',
      );
      await widgetTester.enterText(
        find.byKey(passwordTextFieldKey),
        'sample_password123',
      );
      await widgetTester.tap(find.byKey(signInBtnKey));
      await widgetTester.pumpAndSettle();
      expect(find.text('Splash'), findsOneWidget);
    },
  );
  testWidgets(
    'Should ensure button is in loading state',
    (widgetTester) async {
      whenListen(
        mockSignInPageBloc,
        Stream<SignInPageState>.fromIterable(
          [
            SignInPageState(
              username: 'valid_user',
              status: SignInPageStatus.loading,
              password: 'valid_pass',
              message: '',
            ),
            
          ],
        ),
        initialState: SignInPageState(
            username: '',
            status: SignInPageStatus.writingForm,
            password: '',
            message: ''),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: SignInPage(),
          
        ),
      );
      await widgetTester.enterText(
        find.byKey(usernameTextFieldKey),
        'sample_username',
      );
      await widgetTester.enterText(
        find.byKey(passwordTextFieldKey),
        'sample_password123',
      );
      await widgetTester.tap(find.byKey(signInBtnKey));
      await widgetTester.pumpAndSettle();
      expect(find.text('Signing in...'), findsOneWidget);
    },
  );
}
