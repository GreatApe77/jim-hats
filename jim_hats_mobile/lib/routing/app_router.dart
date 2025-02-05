import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/routing/app_routes.dart';
import 'package:jim_hats_mobile/ui/views/create_account/create_account_page.dart';
import 'package:jim_hats_mobile/ui/views/home/home_page.dart';
import 'package:jim_hats_mobile/ui/views/settings/cubit/settings_cubit.dart';
import 'package:jim_hats_mobile/ui/views/settings/settings_page.dart';
import 'package:jim_hats_mobile/ui/views/sign_in/sign_in_page.dart';
import 'package:jim_hats_mobile/ui/views/welcome/welcome_page.dart';

abstract class AppRouter {
  static String initialRoute = AppRoutes.welcome;
  static Route? ongenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => WelcomePage(),
        );
      case AppRoutes.createAccount:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => CreateAccountPage(),
        );
      case AppRoutes.sigin:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SignInPage(),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => HomePage(),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SettingsPage(
            settingsCubit: locator.get<SettingsCubit>(),
          ),
        );
      default:
        return null;
    }
  }
}
