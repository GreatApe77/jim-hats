import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/routing/app_routes.dart';
import 'package:jim_hats_mobile/ui/views/create_account/create_account_page.dart';
import 'package:jim_hats_mobile/ui/views/sign_in/sign_in_page.dart';
import 'package:jim_hats_mobile/ui/views/welcome/welcome_page.dart';

abstract class AppRouter {
  static String initialRoute = AppRoutes.welcome;
  static Route? ongenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (context) => WelcomePage(),
        );
      case AppRoutes.createAccount:
        return MaterialPageRoute(
          builder: (context) => CreateAccountPage(),
        );
      case AppRoutes.sigin:
        return MaterialPageRoute(
          builder: (context) => SignInPage(),
        );
      default:
        return null;
    }
  }
}
