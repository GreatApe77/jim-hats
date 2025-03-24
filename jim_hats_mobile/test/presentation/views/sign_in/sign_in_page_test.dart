import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/blocs/sign_in_page/sign_in_page_bloc.dart';
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
}
