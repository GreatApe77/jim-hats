import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/widgets/app_drawer/app_drawer.dart';
import 'package:mocktail/mocktail.dart';

class MockAppDrawerCubit extends MockCubit<AppDrawerState>
    implements AppDrawerCubit {}

void main() {
  late AppDrawerCubit mockAppDrawerCubit;
  setUp(
    () {
      mockAppDrawerCubit = MockAppDrawerCubit();
    },
  );
  testWidgets(
    'Should display initial static data',
    (widgetTester) async {
      when(
        () => mockAppDrawerCubit.state,
      ).thenReturn(AppDrawerInitial());
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppDrawer(
              appDrawerCubit: mockAppDrawerCubit,
            ),
          ),
        ),
      );
      expect(find.text('Create group'), findsOne);
      expect(find.text('Join group'), findsOne);
      expect(find.text('Completed challenges'), findsOne);
      expect(find.text('Settings'), findsOne);
      expect(find.text('Help & feedback'), findsOne);
      expect(find.text('About'), findsOne);
    },
  );
}
