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
  // tearDownAll(
  //   () async {
  //     locator.unregister<SignInPageBloc>();
  //   },
  // );
  testWidgets('Should update bloc state when typing on username form field',
      (tester) async {
    when(() => mockSignInPageBloc.state).thenReturn(
      SignInPageState(
          username: 'username',
          status: SignInPageStatus.writingForm,
          password: '',
          message: ''),
    );
    
    await tester.pumpWidget(MaterialApp(
      home: SignInPage(),
    ));
    final usernameTextField = find.byKey(Key('SignInView.username_field'));

    await tester.enterText(usernameTextField, 'Mateus');
    //await tester.pumpAndSettle();
    verify(() => mockSignInPageBloc.add(SignInUsernameChanged(username: 'Mateus')),).called(1);
  });
}