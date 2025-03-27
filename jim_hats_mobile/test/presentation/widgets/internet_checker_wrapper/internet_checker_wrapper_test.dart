import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/app.dart';
import 'package:jim_hats_mobile/presentation/cubits/internet_connectivity/cubit/internet_connectivity_cubit.dart';
import 'package:jim_hats_mobile/presentation/widgets/internet_checker_wrapper/internet_checker_wrapper.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectivityCubit extends MockCubit<InternetConnectivityState>
    implements InternetConnectivityCubit {}

void main() {
  late MockInternetConnectivityCubit mockInternetConnectivityCubit;
  setUp(
    () {
      mockInternetConnectivityCubit = MockInternetConnectivityCubit();
    },
  );

  testWidgets(
    'Should display child',
    (widgetTester) async {
      when(
        () => mockInternetConnectivityCubit.state,
      ).thenReturn(
        InternetConnectivityState(status: InternetConnectivityStatus.connected),
      );
      await widgetTester.pumpWidget(BlocProvider<InternetConnectivityCubit>(
        create: (context) => mockInternetConnectivityCubit,
        child: MaterialApp(
          home: InternetCheckerWrapper(child: Text('HERE')),
        ),
      ));
      expect(find.text('HERE'), findsOne);
    },
  );
  testWidgets(
    'Should display disconnected banner',
    (widgetTester) async {
      whenListen(
        mockInternetConnectivityCubit,
        Stream<InternetConnectivityState>.fromIterable([
          InternetConnectivityState(
            status: InternetConnectivityStatus.disconnected,
          )
        ]),
        initialState: InternetConnectivityStatus.disconnected,
      );
      await widgetTester.pumpWidget(
        BlocProvider<InternetConnectivityCubit>(
          create: (context) => mockInternetConnectivityCubit,
          child: MaterialApp(
            scaffoldMessengerKey: scaffoldMessengerKey,
            home: InternetCheckerWrapper(
              child: Scaffold(
                body: Text('HERE'),
              ),
            ),
          ),
        ),
      );
      await widgetTester.pumpAndSettle();
      expect(find.text('No internet connection! Enable your wifi or mobile data to continue'),findsOne);
      //await expect(find.text('HERE'), findsOne);
    },
  );
}
