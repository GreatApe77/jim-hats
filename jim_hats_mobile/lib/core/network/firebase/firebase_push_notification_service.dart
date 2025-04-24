import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebasePushNotificationService {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    final notificationSettings = await firebaseMessaging.requestPermission();
    if (notificationSettings.authorizationStatus !=
        AuthorizationStatus.authorized) {
      return;
    }

    final fcmToken = await firebaseMessaging.getToken();
    if (kDebugMode) {
      print(fcmToken);
    }
  }
}
