import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:jim_hats_mobile/presentation/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_challenge_page/create_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_account_page/create_account_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_page/gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_details_page/gym_challenge_details_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/internet_connectivity/cubit/internet_connectivity_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/join_group_page/join_group_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge_details/gym_challenge_details_page.dart';
import 'package:jim_hats_mobile/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/new_check_in_page/new_check_in_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/ranking_page/ranking_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/settings_page/settings_cubit.dart';
import 'package:jim_hats_mobile/presentation/blocs/sign_in_page/sign_in_page_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/user_stats_page/user_stats_cubit.dart';

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
    ..registerFactory<InternetConnectivityCubit>(
      () => InternetConnectivityCubit(),
    )
    ..registerFactory<JoinGroupPageCubit>(
      () => JoinGroupPageCubit(
          gymChallengesRepository: locator.get<GymChallengesRepository>()),
    )
    ..registerFactory<CreateChallengePageCubit>(() => CreateChallengePageCubit(
          gymChallengesRepository: locator.get<GymChallengesRepository>(),
          uploadRepository: locator.get<UploadRepository>(),
        ))
    ..registerFactory<HomePageCubit>(() => HomePageCubit(
        loggedUserRepository: locator.get<LoggedUserRepository>()))
    ..registerFactoryParam<NewCheckInPageCubit, XFile, dynamic>(
      (param1, param2) => NewCheckInPageCubit(
          checkInPhoto: param1,
          uploadRepository: locator.get<UploadRepository>(),
          exerciseLogsRepositoy: locator.get<ExerciseLogsRepository>()),
    )
    ..registerFactory<GymChallengeDetailsPageCubit>(() =>
        GymChallengeDetailsPageCubit(
            gymChallengesRepository: locator.get<GymChallengesRepository>(),
            loggedUserRepository: locator.get<LoggedUserRepository>()))
    ..registerFactory<AuthCubit>(() => AuthCubit(
        authRepository: locator.get<AuthRepository>(),
        loggedUserRepository: locator.get<LoggedUserRepository>()))
    ..registerFactory<SignInPageBloc>(
        () => SignInPageBloc(authRepository: locator.get<AuthRepository>()))
    ..registerFactory<CreateAccountPageCubit>(
      () => CreateAccountPageCubit(
        authRepository: locator.get<AuthRepository>(),
        uploadRepository: locator.get<UploadRepository>(),
      ),
    )
    ..registerFactory<GymChallengePageCubit>(() => GymChallengePageCubit(
        gymChallengesRepository: locator.get<GymChallengesRepository>(),
        loggedUserRepository: locator.get<LoggedUserRepository>(),
        exerciseLogsRepository: locator.get<ExerciseLogsRepository>()))
    ..registerFactory<AppDrawerCubit>(() => AppDrawerCubit(
        gymChallengesRepository: locator.get<GymChallengesRepository>(),
        loggedUserRepository: locator.get<LoggedUserRepository>()))
    ..registerFactory<SettingsCubit>(() => SettingsCubit(
        loggedUserRepository: locator.get<LoggedUserRepository>(),
        uploadRepository: locator.get<UploadRepository>()))
    ..registerFactory<ThemeBloc>(() => ThemeBloc(
        settingsRepository: locator.get<SettingsRepository>(),
        themeState: locator.get<SettingsRepository>().settings.isDarkTheme
            ? ThemeDark()
            : ThemeLight()))
    ..registerFactory<UserStatsCubit>(() => UserStatsCubit(
          exerciseLogRepository: locator.get<ExerciseLogsRepository>(),
          loggedUserRepository: locator.get<LoggedUserRepository>(),
        ))
    ..registerFactory<RankingPageCubit>(() => RankingPageCubit(
        //gymChallengesRepository: null,
        //loggedUserRepository: null
        ));
}

Future<void> loadSettings() async {
  await locator.get<SettingsRepository>().loadSettings();
}

final blocProviders = [
  BlocProvider<ThemeBloc>(
    create: (context) => locator.get<ThemeBloc>(),
  ),
  BlocProvider<AuthCubit>(
    create: (context) => locator.get<AuthCubit>(),
  ),
  BlocProvider<InternetConnectivityCubit>(
    create: (context) => locator.get<InternetConnectivityCubit>(),
  ),
];
