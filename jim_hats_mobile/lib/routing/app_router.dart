import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/routing/app_routes.dart';
import 'package:jim_hats_mobile/ui/views/check_in_page/check_in_page.dart';
import 'package:jim_hats_mobile/ui/views/check_in_page/check_in_page_arguments.dart';
import 'package:jim_hats_mobile/ui/views/create_account/create_account_page.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/cubit/gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/gym_challenge_page.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge_details/gym_challenge_details_page.dart';
import 'package:jim_hats_mobile/ui/views/home/home_page.dart';
import 'package:jim_hats_mobile/ui/views/new_check_in/new_check_in_page.dart';
import 'package:jim_hats_mobile/ui/views/new_check_in/new_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/ui/views/ranking/cubit/ranking_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/ranking/ranking_page.dart';
import 'package:jim_hats_mobile/ui/views/settings/cubit/settings_cubit.dart';
import 'package:jim_hats_mobile/ui/views/settings/settings_page.dart';
import 'package:jim_hats_mobile/ui/views/sign_in/sign_in_page.dart';
import 'package:jim_hats_mobile/ui/views/user_stats/cubit/user_stats_cubit.dart';
import 'package:jim_hats_mobile/ui/views/user_stats/user_stats_page.dart';
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
      case AppRoutes.gymChallengeDetails:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => GymChallengeDetailsPage(
                pageArguments:
                    settings.arguments as GymChallengePageArguments));
      case AppRoutes.newCheckIn:
        final arguments = settings.arguments as NewCheckInPageArguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => NewCheckInPage(
                  pageArguments: arguments,
                ));
      case AppRoutes.ranking:
        final arguments = settings.arguments as GymChallengePageArguments;
        return MaterialPageRoute(
          builder: (context) => RankingPage(
              arguments: arguments,
              rankingPageCubit: locator.get<RankingPageCubit>()),
        );
      case AppRoutes.userStats:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => UserStatsPage(
            userStatsCubit: locator.get<UserStatsCubit>(),
          ),
        );
      case AppRoutes.gymChallenge:
        final arguments = settings.arguments as GymChallengePageArguments;

        return MaterialPageRoute(
          settings: settings,
          builder: (context) => GymChallengePage(
            gymChallengePageCubit: locator.get<GymChallengePageCubit>(),
            gymChallengePageArguments: arguments,
          ),
        );
      case AppRoutes.checkIn:
        final arguments = settings.arguments as CheckInPageArguments;

        return MaterialPageRoute(
          settings: settings,
          builder: (context) => CheckInPage(
            checkInPageArguments: arguments,
          ),

        );

      default:
        return null;
    }
  }
}
