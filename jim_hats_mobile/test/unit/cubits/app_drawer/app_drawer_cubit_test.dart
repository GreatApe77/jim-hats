import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:mockito/annotations.dart';

import 'app_drawer_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LoggedUserRepository>(),
  MockSpec<GymChallengesRepository>(),
])
void main() {
  late AppDrawerCubit sut;
  late MockLoggedUserRepository mockLoggedUserRepository;
  late MockGymChallengesRepository mockGymChallengesRepository;
  setUp(
    () {
      mockGymChallengesRepository = MockGymChallengesRepository();
      mockLoggedUserRepository = MockLoggedUserRepository();
      sut = AppDrawerCubit(
        loggedUserRepository: mockLoggedUserRepository,
        gymChallengesRepository: mockGymChallengesRepository,
      );
    },
  );
  test(
    'Should start with blank initial state',
    () {
      expect(sut.state, isA<AppDrawerInitial>());
    },
  );
  blocTest<AppDrawerCubit, AppDrawerState>(
    'Should load drawer data',
    build: () => sut,
    act: (cubit) => cubit.loadDrawerData(),
    expect: () => [
      isA<AppDrawerLoadDataInProgress>(),
      isA<AppDrawerLoadDataSuccess>().having(
        (state) => state.loggedUser,
        'Logged user',
        isA<LoggedUser>(),
      ).having(
        (state) => state.challenges,
        'Challenges',
        isA<List<GymChallenge>>(),
      ),
    ],
  );
}
