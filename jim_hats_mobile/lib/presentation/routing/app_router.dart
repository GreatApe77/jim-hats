import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/check_in_page/check_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/check_in_page/check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/create-chalenge/create_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/create_account/create_account_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_check_in/edit_check_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_check_in/edit_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge_details/gym_challenge_details_page.dart';
import 'package:jim_hats_mobile/presentation/views/home/home_page.dart';
import 'package:jim_hats_mobile/presentation/views/join_group/join_group_page.dart';
import 'package:jim_hats_mobile/presentation/views/new_check_in/new_check_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/new_check_in/new_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/ranking/ranking_page.dart';
import 'package:jim_hats_mobile/presentation/views/ranking/ranking_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/server_down/server_down_alert_page.dart';
import 'package:jim_hats_mobile/presentation/views/settings/settings_page.dart';
import 'package:jim_hats_mobile/presentation/views/sign_in/sign_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/splash/splah_page.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/user_stats/user_stats_page.dart';
import 'package:jim_hats_mobile/presentation/views/welcome/welcome_page.dart';
import 'package:jim_hats_mobile/presentation/widgets/custom_page_route/custom_page_route.dart';

abstract class AppRouter {
  static String initialRoute = AppRoutes.splash;
  static Route? ongenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => BlocListener<AuthCubit, AuthState>(
            bloc: context.read<AuthCubit>()..checkAuthStatus(),
            listener: (context, state) {
              if (state.failed) {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.serverDown);
              }
              switch (state.authStatus) {
                case AuthStatus.authenticated:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.home,
                    (route) => false,
                  );

                  break;
                case AuthStatus.unauthenticated:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.welcome,
                    (route) => false,
                  );
                default:
              }
            },
            child: const SplahPage(),
          ),
        );
      case AppRoutes.welcome:
        return CustomPageRouteBuilder(
          settings: settings,
          child: const WelcomePage(),
        );
      case AppRoutes.editCheckin:
        return CustomPageRouteBuilder(
          settings: settings,
          child: EditCheckInPage(
            editCheckInPageArguments:
                settings.arguments as EditCheckInPageArguments,
          ),
        );
      case AppRoutes.createAccount:
        return CustomPageRouteBuilder(
          settings: settings,
          child: const CreateAccountPage(),
        );
      case AppRoutes.signin:
        return CustomPageRouteBuilder(
          settings: settings,
          child: SignInPage(),
        );
      case AppRoutes.home:
        return CustomPageRouteBuilder(
          settings: settings,
          child: const HomePage(),
        );
      case AppRoutes.settings:
        return CustomPageRouteBuilder(
          settings: settings,
          child: const SettingsPage(),
        );
      case AppRoutes.gymChallengeDetails:
        return CustomPageRouteBuilder(
          settings: settings,
          child: GymChallengeDetailsPage(
            pageArguments: settings.arguments as GymChallengePageArguments,
          ),
        );
      case AppRoutes.newCheckIn:
        final arguments = settings.arguments as NewCheckInPageArguments;

        return CustomPageRouteBuilder(
            settings: settings,
            child: NewCheckInPage(
              pageArguments: arguments,
            ));
      case AppRoutes.ranking:
        final arguments = settings.arguments as RankingPageArguments;

        return CustomPageRouteBuilder(
          settings: settings,
          child: RankingPage(
            rankingPageArguments: arguments,
          ),
        );
      case AppRoutes.userStats:
        return CustomPageRouteBuilder(
          settings: settings,
          child: UserStatsPage(),
        );
      case AppRoutes.gymChallenge:
        final arguments = settings.arguments as GymChallengePageArguments;
        return CustomPageRouteBuilder(
          settings: settings,
          child: GymChallengePage(
            gymChallengePageArguments: arguments,
          ),
        );
      case AppRoutes.checkIn:
        final arguments = settings.arguments as CheckInPageArguments;

        return CustomPageRouteBuilder(
          settings: settings,
          child: CheckInPage(
            checkInPageArguments: arguments,
          ),
        );
      case AppRoutes.serverDown:
        return MaterialPageRoute(
          builder: (context) => ServerDownAlertPage(),
        );
      case AppRoutes.createChallenge:
        return CustomPageRouteBuilder(
          settings: settings,
          child: const CreateChallengePage(),
        );
      case AppRoutes.joinGroup:
        return CustomPageRouteBuilder(
          settings: settings,
          child: const JoinGroupPage(),
        );
      case AppRoutes.userCalendars:
        return CustomPageRouteBuilder(
          settings: settings,
          child: UserCalendarsPage(
            calendarsPageArguments:
                settings.arguments as UserCalendarsPageArguments,
          ),
        );
      case AppRoutes.editGymChallenge:
        return CustomPageRouteBuilder(
          settings: settings,
          child: EditGymChallengePage(
            editGymChallengePageArguments:
                settings.arguments as EditGymChallengePageArguments,
          ),
        );
      default:
        return null;
    }
  }
}
