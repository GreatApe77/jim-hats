import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/join_group_page/join_group_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/join_group/join_group_page.dart';
import 'package:mocktail/mocktail.dart';

class MockJoinGroupPageCubit extends MockCubit<JoinGroupPageState>
    implements JoinGroupPageCubit {}

void main() {
  late MockJoinGroupPageCubit mockJoinGroupPageCubit;
  setUp(
    () {
      mockJoinGroupPageCubit = MockJoinGroupPageCubit();
      locator.registerFactory<JoinGroupPageCubit>(
        () => mockJoinGroupPageCubit,
      );
    },
  );
  tearDown(
    () {
      locator.unregister<JoinGroupPageCubit>();
    },
  );

  testWidgets(
    'Should display main form components',
    (widgetTester) async {
      when(
        () => mockJoinGroupPageCubit.state,
      ).thenReturn(
        JoinGroupPageState(
            groupCode: '', status: JoinGroupPageStatus.idle, errorMessage: ''),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: JoinGroupPage(),
        ),
      );
      expect(find.byKey(JoinGroupView.joinGroupBtnKey), findsOneWidget);
      expect(find.byKey(JoinGroupView.groupCodeTextFieldKey), findsOneWidget);
    },
  );
  testWidgets(
    'Should not submit form because group code is invalid',
    (widgetTester) async {
      when(
        () => mockJoinGroupPageCubit.state,
      ).thenReturn(
        JoinGroupPageState(
          groupCode: '',
          status: JoinGroupPageStatus.idle,
          errorMessage: '',
        ),
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: JoinGroupPage(),
        ),
      );
      await widgetTester.enterText(
        find.byKey(JoinGroupView.groupCodeTextFieldKey),
        'invalid',
      );
      await widgetTester.tap(
        find.byKey(JoinGroupView.joinGroupBtnKey),
      );
      await widgetTester.pumpAndSettle();
      expect(find.text('Invalid group code'), findsOne);
    },
  );
  testWidgets(
    'Should display snack bar with error message when form fails',
    (widgetTester) async {
      final errorMsg = 'GONE WRONG!';
      whenListen(
        mockJoinGroupPageCubit,
        Stream<JoinGroupPageState>.fromIterable([
          JoinGroupPageState(
            groupCode: 'groupCode',
            status: JoinGroupPageStatus.error,
            errorMessage: errorMsg,
          )
        ]),
        initialState: JoinGroupPageState(
          groupCode: '',
          status: JoinGroupPageStatus.idle,
          errorMessage: '',
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: JoinGroupPage(),
        ),
      );
      await widgetTester.enterText(
        find.byKey(JoinGroupView.groupCodeTextFieldKey),
        'd198bc10-cc2d-41f9-9940-307d3bb78c0f',
      );
      await widgetTester.tap(find.byKey(JoinGroupView.joinGroupBtnKey));
      await widgetTester.pump();
      expect(find.text(errorMsg), findsOne);
      expect(find.byType(SnackBar), findsOneWidget);
    },
  );
}
