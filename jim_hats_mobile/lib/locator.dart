import 'package:get_it/get_it.dart';
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
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/ui/theme/bloc/theme_bloc.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/cubit/gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/settings/cubit/settings_cubit.dart';
import 'package:jim_hats_mobile/ui/views/user_stats/cubit/user_stats_cubit.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  //Data Sources
  locator.registerSingleton<LoggedUserDataSource>(MemoryLoggedUserDataSource());
  locator.registerSingleton<GymChallengeDataSource>(
      MemoryGymChallengeDataSource());
  locator.registerSingleton<SettingsDataSource>(
      SharedPreferencesSettingsDataSource());

  locator
      .registerSingleton<ExerciseLogDataSource>(MemoryExerciseLogDataSource());
  //Repositories
  locator.registerSingleton<LoggedUserRepository>(LoggedUserRepository(
      loggedUserDataSource: locator.get<LoggedUserDataSource>()));
  locator.registerSingleton<GymChallengesRepository>(GymChallengesRepository(
      gymChallengeDataSource: locator.get<GymChallengeDataSource>()));
  locator.registerSingleton<SettingsRepository>(SettingsRepository(
      settingsDataSource: locator.get<SettingsDataSource>()));
  locator.registerSingleton<ExerciseLogsRepository>(ExerciseLogsRepository(
      exerciseLogDataSource: locator.get<ExerciseLogDataSource>()));
  //load settings
  await loadSettings();

  //Cubits
  locator.registerFactory(
    () => GymChallengePageCubit(
        gymChallengesRepository: locator.get<GymChallengesRepository>(),
        loggedUserRepository: locator.get<LoggedUserRepository>(),
        exerciseLogsRepository: locator.get<ExerciseLogsRepository>()),
  );
  locator.registerSingleton<AppDrawerCubit>(
    AppDrawerCubit(
        gymChallengesRepository: locator.get<GymChallengesRepository>(),
        loggedUserRepository: locator.get<LoggedUserRepository>()),
  );
  locator.registerSingleton(
    SettingsCubit(loggedUserRepository: locator.get<LoggedUserRepository>()),
  );
  locator.registerSingleton<ThemeBloc>(ThemeBloc(
      settingsRepository: locator.get<SettingsRepository>(),
      themeState: locator.get<SettingsRepository>().settings.isDarkTheme
          ? ThemeDark()
          : ThemeLight()));

  locator.registerSingleton<UserStatsCubit>(UserStatsCubit(
      loggedUserRepository: locator.get<LoggedUserRepository>()));
}

Future<void> loadSettings() async {
  await locator.get<SettingsRepository>().loadSettings();
}
