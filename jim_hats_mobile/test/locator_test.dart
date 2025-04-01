import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/settings/repositories/settings_repository.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'locator_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SettingsRepository>(),
])
void main() {
  late SettingsRepository mockSettingsRepository;
  tearDown(() async {
    await locator.reset();
  
    
  },);
  test(
    'Should load inital settings of settings repository',
    () async {
      mockSettingsRepository = MockSettingsRepository();

      await expectLater(loadSettings(mockSettingsRepository), completes);
      mockito.verify(mockSettingsRepository.loadSettings()).called(1);
    },
  );
/*   Future<void> registerCubitsAndBlocs() async {
  //Cubits
  locator
    ..registerFactory<EditGymChallengePageCubit>(
      () => EditGymChallengePageCubit(
        gymChallengesRepository: locator.get<GymChallengesRepository>(),
        uploadRepository: locator.get<UploadRepository>(),
      ),
    )
    ..registerFactory<CheckInPageCubit>(
      () => CheckInPageCubit(
        exerciseLogsRepository: locator.get<ExerciseLogsRepository>(),
      ),
    )
    ..registerFactory<EditCheckInPageCubit>(
      () => EditCheckInPageCubit(
        uploadRepository: locator.get<UploadRepository>(),
        exerciseLogsRepository: locator.get<ExerciseLogsRepository>(),
      ),
    )
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
    ..registerFactory<NewCheckInPageCubit>(
      () => NewCheckInPageCubit(
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
    ..registerFactory<RankingPageCubit>(
      () => RankingPageCubit(
        gymChallengesRepository: locator.get<GymChallengesRepository>(),
        loggedUserRepository: locator.get<LoggedUserRepository>(),
      ),
    );
} */
  test('Should setup cubits and blocs',() async {
      late MockSettingsRepository mockSettingsRepository;
      await registerCubitsAndBlocs();
  },);
}
