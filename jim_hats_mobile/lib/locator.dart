import 'package:get_it/get_it.dart';
import 'package:jim_hats_mobile/data/logged_user/data_sources/memory_logged_user_data_source.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  locator.registerSingleton<MemoryLoggedUserDataSource>(
      MemoryLoggedUserDataSource());
  locator.registerSingleton<LoggedUserRepository>(LoggedUserRepository(
      loggedUserDataSource: locator.get<MemoryLoggedUserDataSource>()));

  locator.registerFactory<AppDrawerCubit>(
    () => AppDrawerCubit(
        loggedUserRepository: locator.get<LoggedUserRepository>()),
  );
}
