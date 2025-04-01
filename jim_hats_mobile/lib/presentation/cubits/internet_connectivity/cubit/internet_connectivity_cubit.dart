import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_connectivity_state.dart';

class InternetConnectivityCubit extends Cubit<InternetConnectivityState> {
  late StreamSubscription<List<ConnectivityResult>> subscription;

  InternetConnectivityCubit({required Connectivity connectivity})
      : super(
          InternetConnectivityState(
            status: InternetConnectivityStatus.unknown,
          ),
        ) {
    subscription =
        connectivity.onConnectivityChanged.listen(_connectivityListener);
  }

  void _connectivityListener(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      emit(state.copyWith(status: InternetConnectivityStatus.connected));
    } else {
      emit(state.copyWith(status: InternetConnectivityStatus.disconnected));
    }
  }

  @override
  Future<void> close() async {
    subscription.cancel();
    super.close();
  }
}
