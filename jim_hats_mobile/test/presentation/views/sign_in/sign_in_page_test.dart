import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/blocs/sign_in_page/sign_in_page_bloc.dart';
import 'package:jim_hats_mobile/presentation/views/sign_in/sign_in_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSignInPageBloc extends MockBloc<SignInPageEvent, SignInPageState>
    implements SignInPageBloc {}

//@GenerateNiceMocks([MockSpec<SignInPageBloc>()])
void main() {
  late MockSignInPageBloc mockSignInPageBloc;
  setUp(
    () {
      mockSignInPageBloc = MockSignInPageBloc();
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
  testWidgets('sign in page ...', (tester) async {
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
    
  });
}
