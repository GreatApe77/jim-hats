part of 'internet_connectivity_cubit.dart';

enum InternetConnectivityStatus { unknown, connected, disconnected }

final class InternetConnectivityState {
  final InternetConnectivityStatus status;

  InternetConnectivityState({required this.status});

  copyWith({InternetConnectivityStatus? status}) {
    return InternetConnectivityState(status: status ?? this.status);
  }
}
