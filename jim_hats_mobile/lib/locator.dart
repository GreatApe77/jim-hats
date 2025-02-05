import 'package:get_it/get_it.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/data_sources/memory_gym_challenge_data_source.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/memory_logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  //Data Sources
  locator.registerSingleton<LoggedUserDataSource>(MemoryLoggedUserDataSource());
  locator.registerSingleton<GymChallengeDataSource>(
      MemoryGymChallengeDataSource());
  //Repositories
  locator.registerSingleton<LoggedUserRepository>(LoggedUserRepository(
      loggedUserDataSource: locator.get<LoggedUserDataSource>()));
  locator.registerSingleton<GymChallengesRepository>(GymChallengesRepository(
      gymChallengeDataSource: locator.get<GymChallengeDataSource>()));

  //Cubits
  locator.registerFactory<AppDrawerCubit>(
    () => AppDrawerCubit(
        gymChallengesRepository: locator.get<GymChallengesRepository>(),
        loggedUserRepository: locator.get<LoggedUserRepository>()),
  );
}
