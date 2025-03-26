import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/internet_connectivity/cubit/internet_connectivity_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_router.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/create-chalenge/create_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/server_down/server_down_alert_page.dart';
import 'package:jim_hats_mobile/presentation/views/welcome/welcome_page.dart';

void main() {
  testWidgets(
    'Should route to welcome page',
    (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        initialRoute: AppRoutes.welcome,
        onGenerateRoute: AppRouter.ongenerateRoute,
      ));
      expect(find.byType(WelcomePage), findsOneWidget);
    },
  );
  testWidgets(
    'Should route to server down',
    (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        initialRoute: AppRoutes.serverDown,
        onGenerateRoute: AppRouter.ongenerateRoute,
      ));
      expect(find.byType(ServerDownAlertPage), findsOneWidget);
    },
  );
  // testWidgets(
  //   'Should route to create challenge page',
  //   (widgetTester) async {
  //     await widgetTester.pumpWidget(MaterialApp(
  //       initialRoute: AppRoutes.createChallenge,
  //       onGenerateRoute: AppRouter.ongenerateRoute,
  //     ));
  //     expect(find.byType(CreateChallengePage), findsOneWidget);
  //   },
  // );
  test(
    'Should initialize bloc providers for global bloc/cubit',
    () {
      final themeBlocProv = blocProviders.firstWhere(
        (element) => element is BlocProvider<ThemeBloc>,
      );
      final authBlocProvider = blocProviders.firstWhere(
        (element) => element is BlocProvider<AuthCubit>,
      );
      final internetConnecivityBlocProvider = blocProviders.firstWhere(
        (element) => element is BlocProvider<InternetConnectivityCubit>,
      );
      expect(themeBlocProv, isA<BlocProvider>());
      expect(authBlocProvider, isA<BlocProvider>());
      expect(internetConnecivityBlocProvider, isA<BlocProvider>());
    },
  );
}
