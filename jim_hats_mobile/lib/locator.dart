import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/network_auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/memory_exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/memory_gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/memory_logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/shared_preferences_settings_data_source.dart';
import 'package:jim_hats_mobile/data/settings/repositories/settings_repository.dart';
import 'package:jim_hats_mobile/shared/http/http_client.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/ui/theme/bloc/theme_bloc.dart';
import 'package:jim_hats_mobile/ui/views/create_account/cubit/create_account_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/cubit/gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/ranking/cubit/ranking_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/settings/cubit/settings_cubit.dart';
import 'package:jim_hats_mobile/ui/views/user_stats/cubit/user_stats_cubit.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  //OTHER
  locator
    ..registerSingleton<HttpClient>(HttpClient(dio: Dio()))

    //Data Sources
    ..registerSingleton<LoggedUserDataSource>(MemoryLoggedUserDataSource())
    ..registerSingleton<GymChallengeDataSource>(MemoryGymChallengeDataSource())
    ..registerSingleton<SettingsDataSource>(
        SharedPreferencesSettingsDataSource())
    ..registerSingleton<ExerciseLogDataSource>(MemoryExerciseLogDataSource())
    ..registerSingleton<AuthDataSource>(
        NetworkAuthDataSource(httpClient: locator.get<HttpClient>()))
    //Repositories
    ..registerSingleton<AuthRepository>(
        AuthRepository(authDataSource: locator.get<AuthDataSource>()))
    ..registerSingleton<LoggedUserRepository>(LoggedUserRepository(
        loggedUserDataSource: locator.get<LoggedUserDataSource>()))
    ..registerSingleton<GymChallengesRepository>(GymChallengesRepository(
        gymChallengeDataSource: locator.get<GymChallengeDataSource>()))
    ..registerSingleton<SettingsRepository>(SettingsRepository(
        settingsDataSource: locator.get<SettingsDataSource>()))
    ..registerSingleton<ExerciseLogsRepository>(ExerciseLogsRepository(
        exerciseLogDataSource: locator.get<ExerciseLogDataSource>()));
  //load settings
  await loadSettings();

  //Cubits
  locator
    ..registerSingleton<CreateAccountPageCubit>(CreateAccountPageCubit())
    ..registerFactory(
      () => GymChallengePageCubit(
          gymChallengesRepository: locator.get<GymChallengesRepository>(),
          loggedUserRepository: locator.get<LoggedUserRepository>(),
          exerciseLogsRepository: locator.get<ExerciseLogsRepository>()),
    )
    ..registerSingleton<AppDrawerCubit>(
      AppDrawerCubit(
          gymChallengesRepository: locator.get<GymChallengesRepository>(),
          loggedUserRepository: locator.get<LoggedUserRepository>()),
    )
    ..registerSingleton(
      SettingsCubit(loggedUserRepository: locator.get<LoggedUserRepository>()),
    )
    ..registerSingleton<ThemeBloc>(ThemeBloc(
        settingsRepository: locator.get<SettingsRepository>(),
        themeState: locator.get<SettingsRepository>().settings.isDarkTheme
            ? ThemeDark()
            : ThemeLight()))
    ..registerSingleton<UserStatsCubit>(UserStatsCubit(
        loggedUserRepository: locator.get<LoggedUserRepository>()))
    ..registerSingleton<RankingPageCubit>(RankingPageCubit(
        //gymChallengesRepository: null,
        //loggedUserRepository: null
        ));
}

Future<void> loadSettings() async {
  await locator.get<SettingsRepository>().loadSettings();
}
