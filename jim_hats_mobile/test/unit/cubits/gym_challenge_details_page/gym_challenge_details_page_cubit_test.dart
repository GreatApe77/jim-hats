import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_details_page/gym_challenge_details_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'gym_challenge_details_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GymChallengesRepository>(),
  MockSpec<LoggedUserRepository>(),
])
void main() {
  late GymChallengeDetailsPageCubit sut;
  late MockGymChallengesRepository mockGymChallengesRepository;
  late MockLoggedUserRepository mockLoggedUserRepository;
  const sampleChallengeId = 9;
  setUp(
    () {
      mockLoggedUserRepository = MockLoggedUserRepository();
      mockGymChallengesRepository = MockGymChallengesRepository();
      sut = GymChallengeDetailsPageCubit(
        gymChallengesRepository: mockGymChallengesRepository,
        loggedUserRepository: mockLoggedUserRepository,
      );
    },
  );
  test(
    'Should have empty initial state',
    () {
      expect(sut.state, isA<GymChallengeDetailsPageInitial>());
    },
  );
  
  blocTest<GymChallengeDetailsPageCubit, GymChallengeDetailsPageState>(
    'Should handle exception while loading page data',
    setUp: () {
      when(mockLoggedUserRepository.getLoggedUser()).thenThrow(Error());
    },
    build: () => sut,
    act: (cubit) => cubit.loadData(sampleChallengeId),
    expect: () => [
      isA<GymChallengeDetailsPageLoadDataInProgress>(),
      isA<GymChallengeDetailsPageLoadError>(),
    ],
  );
}
