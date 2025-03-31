import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoggedUserRepository>()])
void main() {
  late MockLoggedUserRepository mockLoggedUserRepository;
  late HomePageCubit sut;
  final sampleHomePageData =
      LoggedUser(id: 1, username: 'mateus', email: 'mateus@gmail.com');
  setUp(
    () {
      mockLoggedUserRepository = MockLoggedUserRepository();
      sut = HomePageCubit(loggedUserRepository: mockLoggedUserRepository);
    },
  );

  test(
    'Intial state must be HomePageDataInitial',
    () {
      expect(sut.state, isA<HomePageDataInitial>());
    },
  );
  blocTest<HomePageCubit, HomePageState>(
    'Should load page data with a logged user',
    setUp: () {
      when(mockLoggedUserRepository.getLoggedUser()).thenAnswer(
        (_) async => sampleHomePageData,
      );
    },
    build: () => sut,
    act: (cubit) => cubit.loadData(),
    expect: () => [
      isA<HomePageDataLoading>(),
      isA<HomePageDataSuccess>()
          .having((data) => data.loggedUser.username, 'Username', 'mateus')
    ],
  );
  blocTest<HomePageCubit, HomePageState>(
    'Should handle an error while loading home paga data',
    setUp: () {
      when(mockLoggedUserRepository.getLoggedUser()).thenThrow(Error());
    },
    build: () => sut,
    act: (cubit) => cubit.loadData(),
    expect: () => [isA<HomePageDataLoading>(), isA<HomePageDataError>()],
  );
}
