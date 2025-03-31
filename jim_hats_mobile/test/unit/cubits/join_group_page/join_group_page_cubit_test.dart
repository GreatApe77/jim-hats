import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/join_group_page/join_group_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'join_group_page_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GymChallengesRepository>()])
void main() {
  late JoinGroupPageCubit sut;
  late MockGymChallengesRepository mockGymChallengesRepository;
  final sampleApplicationException = TimeOutException();
  setUp(
    () {
      mockGymChallengesRepository = MockGymChallengesRepository();
      sut = JoinGroupPageCubit(
        gymChallengesRepository: mockGymChallengesRepository,
      );
    },
  );
  test(
    'Should start with initial empty state',
    () {
      expect(sut.state.status, JoinGroupPageStatus.idle);
      expect(sut.state.groupCode, '');
      expect(sut.state.errorMessage, '');
    },
  );
  blocTest<JoinGroupPageCubit, JoinGroupPageState>(
    'Should update group code',
    build: () => sut,
    act: (cubit) => cubit.updateGroupCode('1234'),
    expect: () => [
      isA<JoinGroupPageState>().having(
        (state) => state.groupCode,
        'Group code',
        '1234',
      ),
    ],
  );
  blocTest<JoinGroupPageCubit, JoinGroupPageState>(
    'Should join gym challenge by group code',
    build: () => sut,
    act: (cubit) => cubit.submitForm(),
    expect: () => [
      isA<JoinGroupPageState>().having(
        (state) => state.status,
        'Status',
        JoinGroupPageStatus.loading,
      ),
      isA<JoinGroupPageState>().having(
        (state) => state.status,
        'Status',
        JoinGroupPageStatus.success,
      ),
    ],
  );
  blocTest<JoinGroupPageCubit, JoinGroupPageState>(
    'Should handle application exception while joining group',
    setUp: () {
      when(
        mockGymChallengesRepository.joinChallenge(any),
      ).thenThrow(
        sampleApplicationException,
      );
    },
    build: () => sut,
    act: (cubit) => cubit.submitForm(),
    expect: () => [
      isA<JoinGroupPageState>().having(
        (state) => state.status,
        'Status',
        JoinGroupPageStatus.loading,
      ),
      isA<JoinGroupPageState>()
          .having(
            (state) => state.status,
            'Status',
            JoinGroupPageStatus.error,
          )
          .having(
            (state) => state.errorMessage,
            'Error message',
            sampleApplicationException.getMessage(),
          ),
    ],
  );
  blocTest<JoinGroupPageCubit, JoinGroupPageState>(
    'Should handle unknown exception while joining group',
    setUp: () {
      when(
        mockGymChallengesRepository.joinChallenge(any),
      ).thenThrow(
        Error(),
      );
    },
    build: () => sut,
    act: (cubit) => cubit.submitForm(),
    expect: () => [
      isA<JoinGroupPageState>().having(
        (state) => state.status,
        'Status',
        JoinGroupPageStatus.loading,
      ),
      isA<JoinGroupPageState>()
          .having(
            (state) => state.status,
            'Status',
            JoinGroupPageStatus.error,
          )
          .having(
            (state) => state.errorMessage,
            'Error message',
            'Unknown error while joining group',
          ),
    ],
  );
}
