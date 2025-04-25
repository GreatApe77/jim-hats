import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jim_hats_mobile/core/network/firebase/firebase_push_notification_service.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  late StreamSubscription _notificationStreamSubscription;
  final FirebasePushNotificationService _firebasePushNotificationService;
  NotificationCubit({
    required FirebasePushNotificationService firebasePushNotificationService,
  })  : _firebasePushNotificationService = firebasePushNotificationService,
        super(NotificationInitial()) {
    _notificationStreamSubscription =
        _firebasePushNotificationService.onForegroundMessageStream.listen(
      _handleForegroundNotification,
    );
  }

  @override
  Future<void> close() {
    _notificationStreamSubscription.cancel();
    return super.close();
  }

  void _handleForegroundNotification(RemoteMessage message) {
    final notificationTitle = message.notification?.title;
    if (notificationTitle != null) {
      emit(NotificationLoaded(title: notificationTitle));
    }
  }
}
