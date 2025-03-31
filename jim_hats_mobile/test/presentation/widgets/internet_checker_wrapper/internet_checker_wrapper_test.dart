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
  final bannerMessage =
      'No internet connection! Enable your wifi or mobile data to continue';
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
        initialState: InternetConnectivityState(
          status: InternetConnectivityStatus.connected,
        ),
      );

      await widgetTester.pumpWidget(
        BlocProvider<InternetConnectivityCubit>(
          create: (context) => mockInternetConnectivityCubit,
          child: MaterialApp(
            scaffoldMessengerKey: scaffoldMessengerKey,
            home: InternetCheckerWrapper(
              child: Scaffold(body: Text('Test Content')),
            ),
          ),
        ),
      );

      await widgetTester.pump();

      expect(find.text(bannerMessage), findsOneWidget);
    },
  );
  testWidgets(
    'Should remove MaterialBanner when internet is reconnected',
    (widgetTester) async {
      whenListen(
        mockInternetConnectivityCubit,
        Stream<InternetConnectivityState>.fromIterable([
          InternetConnectivityState(
            status: InternetConnectivityStatus.disconnected,
          ),
          InternetConnectivityState(
            status: InternetConnectivityStatus.connected,
          ),
        ]),
        initialState: InternetConnectivityState(
          status: InternetConnectivityStatus.connected,
        ),
      );

      await widgetTester.pumpWidget(
        BlocProvider<InternetConnectivityCubit>(
          create: (context) => mockInternetConnectivityCubit,
          child: MaterialApp(
            scaffoldMessengerKey: scaffoldMessengerKey,
            home: InternetCheckerWrapper(
              child: Scaffold(body: Text('Test Content')),
            ),
          ),
        ),
      );

      await widgetTester.pump();
      //expect(find.text(bannerMessage), findsOneWidget);

      
      //await widgetTester.pump(const Duration(milliseconds: 500));

      
      expect(find.text(bannerMessage), findsNothing);
    },
  );
}
