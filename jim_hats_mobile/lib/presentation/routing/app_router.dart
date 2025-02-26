import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/shared/ui/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/ui/views/check_in_page/check_in_page.dart';
import 'package:jim_hats_mobile/ui/views/check_in_page/check_in_page_arguments.dart';
import 'package:jim_hats_mobile/ui/views/create-chalenge/create_challenge_page.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_challenge_page/create_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/create_account/create_account_page.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_account_page/create_account_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_page/gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/gym_challenge_page.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_details_page/gym_challenge_details_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge_details/gym_challenge_details_page.dart';
import 'package:jim_hats_mobile/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/home/home_page.dart';
import 'package:jim_hats_mobile/ui/views/join_group/join_group_page.dart';
import 'package:jim_hats_mobile/presentation/cubits/new_check_in_page/new_check_in_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/new_check_in/new_check_in_page.dart';
import 'package:jim_hats_mobile/ui/views/new_check_in/new_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/cubits/ranking_page/ranking_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/ranking/ranking_page.dart';
import 'package:jim_hats_mobile/ui/views/server_down/server_down_alert_page.dart';
import 'package:jim_hats_mobile/presentation/cubits/settings_page/settings_cubit.dart';
import 'package:jim_hats_mobile/ui/views/settings/settings_page.dart';
import 'package:jim_hats_mobile/presentation/blocs/sign_in_page/sign_in_page_bloc.dart';
import 'package:jim_hats_mobile/ui/views/sign_in/sign_in_page.dart';
import 'package:jim_hats_mobile/ui/views/splash/splah_page.dart';
import 'package:jim_hats_mobile/ui/views/user_stats/cubit/user_stats_cubit.dart';
import 'package:jim_hats_mobile/ui/views/user_stats/user_stats_page.dart';
import 'package:jim_hats_mobile/ui/views/welcome/welcome_page.dart';

abstract class AppRouter {
  static String initialRoute = AppRoutes.splash;
  static Route? ongenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => BlocListener<AuthCubit, AuthState>(
            bloc: locator.get<AuthCubit>()..checkAuthStatus(),
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
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => WelcomePage(),
        );
      case AppRoutes.createAccount:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => CreateAccountPage(
            createAccountPageCubit: locator.get<CreateAccountPageCubit>(),
          ),
        );
      case AppRoutes.signin:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SignInPage(
            signInPageBloc: locator.get<SignInPageBloc>(),
          ),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => HomePage(
            homePageCubit: locator.get<HomePageCubit>(),
          ),
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
                gymChallengeDetailsPageCubit:
                    locator.get<GymChallengeDetailsPageCubit>(),
                pageArguments:
                    settings.arguments as GymChallengePageArguments));
      case AppRoutes.newCheckIn:
        final arguments = settings.arguments as NewCheckInPageArguments;

        return MaterialPageRoute(
            settings: settings,
            builder: (context) => NewCheckInPage(
                  checkInPageCubit:
                      locator.get<NewCheckInPageCubit>(param1: arguments.photo),
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
      case AppRoutes.serverDown:
        return MaterialPageRoute(
          builder: (context) => ServerDownAlertPage(),
        );
      case AppRoutes.createChallenge:
        return MaterialPageRoute(
          builder: (context) => CreateChallengePage(
            createChallengePageCubit: locator.get<CreateChallengePageCubit>(),
          ),
        );
      case AppRoutes.joinGroup:
        return MaterialPageRoute(builder: (context) => JoinGroupPage(),);
      default:
        return null;
    }
  }
}
