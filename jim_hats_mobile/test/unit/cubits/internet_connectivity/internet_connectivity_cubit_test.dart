import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/cubits/internet_connectivity/cubit/internet_connectivity_cubit.dart';
import 'package:mockito/annotations.dart';

import 'internet_connectivity_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Connectivity>()])
void main() {
  late InternetConnectivityCubit sut;
  late MockConnectivity mockConnectivity;
  setUp(
    () {
      mockConnectivity = MockConnectivity();
      sut = InternetConnectivityCubit(connectivity: mockConnectivity);
    },
  );

  test(
    'Should start with unknown initial state',
    () {
      expect(sut.state.status, InternetConnectivityStatus.unknown);
    },
  );
  test(
    'Should close bloc',
    () async {
      await sut.close();

      expect(sut.isClosed, isTrue);
    },
  );

  // blocTest<InternetConnectivityCubit, InternetConnectivityState>(
  //   'emits [MyState] when MyEvent is added.',
  //   build: () => InternetConnectivityCubit(),
  //   act: (bloc) => bloc.add(MyEvent),
  //   expect: () => const <InternetConnectivityCubitState>[MyState],
  // );
}
