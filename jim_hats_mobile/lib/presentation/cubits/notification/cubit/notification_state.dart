part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationLoaded extends NotificationState {
  final String title;

  const NotificationLoaded({required this.title});

  @override
  List<Object> get props => [...super.props, title];
}
