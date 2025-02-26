import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/data_sources/network_auth_data_source.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/memory_exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/data_sources/network_exercise_log_data_source.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/memory_gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/network_gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/network_logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/shared_preferences_settings_data_source.dart';
import 'package:jim_hats_mobile/data/settings/repositories/settings_repository.dart';
import 'package:jim_hats_mobile/data/uploads/data_sources/network_upload_data_source.dart';
import 'package:jim_hats_mobile/data/uploads/data_sources/upload_data_source.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:jim_hats_mobile/core/network/http_client.dart';
import 'package:jim_hats_mobile/shared/ui/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_challenge_page/create_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_account_page/create_account_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/cubit/gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge_details/cubit/gym_challenge_details_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge_details/gym_challenge_details_page.dart';
import 'package:jim_hats_mobile/ui/views/home/cubit/home_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/new_check_in/cubit/new_check_in_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/ranking/cubit/ranking_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/settings/cubit/settings_cubit.dart';
import 'package:jim_hats_mobile/presentation/blocs/sign_in_page/sign_in_page_bloc.dart';
import 'package:jim_hats_mobile/ui/views/user_stats/cubit/user_stats_cubit.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  //OTHER
  locator
    ..registerSingleton<SettingsDataSource>(
        SharedPreferencesSettingsDataSource())
    ..registerSingleton<HttpClient>(HttpClient(dio: Dio()))

    //Data Sources
    ..registerSingleton<UploadDataSource>(
        NetworkUploadDataSource(httpClient: locator.get<HttpClient>()))
    ..registerSingleton<LoggedUserDataSource>(NetworkLoggedUserDataSource(
        httpClient: locator.get<HttpClient>(),
        settingsDataSource: locator.get<SettingsDataSource>()))
    ..registerSingleton<GymChallengeDataSource>(NetworkGymChallengeDataSource(
        settingsDataSource: locator.get<SettingsDataSource>(),
        httpClient: locator.get<HttpClient>()))
    ..registerSingleton<ExerciseLogDataSource>(NetworkExerciseLogDataSource(
        settingsDataSource: locator.get<SettingsDataSource>(),
        httpClient: locator.get<HttpClient>()))
    ..registerSingleton<AuthDataSource>(
        NetworkAuthDataSource(httpClient: locator.get<HttpClient>()))
    //Repositories
    ..registerSingleton<UploadRepository>(UploadRepository(
        networkUploadDataSource: locator.get<UploadDataSource>()))
    ..registerSingleton<AuthRepository>(AuthRepository(
        settingsDatasource: locator.get<SettingsDataSource>(),
        authDataSource: locator.get<AuthDataSource>()))
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
    ..registerSingleton<CreateChallengePageCubit>(CreateChallengePageCubit(
      gymChallengesRepository: locator.get<GymChallengesRepository>(),
      uploadRepository: locator.get<UploadRepository>(),
    ))
    ..registerSingleton<HomePageCubit>(HomePageCubit(
        loggedUserRepository: locator.get<LoggedUserRepository>()))
    ..registerFactoryParam<NewCheckInPageCubit, XFile, dynamic>(
      (param1, param2) => NewCheckInPageCubit(
          checkInPhoto: param1,
          uploadRepository: locator.get<UploadRepository>(),
          exerciseLogsRepositoy: locator.get<ExerciseLogsRepository>()),
    )
    ..registerSingleton<GymChallengeDetailsPageCubit>(
        GymChallengeDetailsPageCubit(
            gymChallengesRepository: locator.get<GymChallengesRepository>(),
            loggedUserRepository: locator.get<LoggedUserRepository>()))
    ..registerSingleton<AuthCubit>(AuthCubit(
        authRepository: locator.get<AuthRepository>(),
        loggedUserRepository: locator.get<LoggedUserRepository>()))
    ..registerSingleton<SignInPageBloc>(
        SignInPageBloc(authRepository: locator.get<AuthRepository>()))
    ..registerSingleton<CreateAccountPageCubit>(CreateAccountPageCubit(
        authRepository: locator.get<AuthRepository>(),
        uploadRepository: locator.get<UploadRepository>()))
    ..registerSingleton<GymChallengePageCubit>(
      GymChallengePageCubit(
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
      SettingsCubit(
          loggedUserRepository: locator.get<LoggedUserRepository>(),
          uploadRepository: locator.get<UploadRepository>()),
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
