import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebasePushNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Stream<RemoteMessage> get onForegroundMessageStream =>
      FirebaseMessaging.onMessage;
  Stream<RemoteMessage> get onBackgroundMessageStream =>
      FirebaseMessaging.onMessageOpenedApp;
  
  late RemoteMessage? initialMessage;
  Future<void> initialize() async {
    await _initializeToken();
    initialMessage = await _firebaseMessaging.getInitialMessage();
  }

  Future<void> _initializeToken() async {
    final notificationSettings = await _firebaseMessaging.requestPermission();
    if (notificationSettings.authorizationStatus !=
        AuthorizationStatus.authorized) {
      return;
    }

    final fcmToken = await _firebaseMessaging.getToken();
    _logToken(fcmToken);
    _firebaseMessaging.onTokenRefresh.listen((fcmToken) {
      _logToken(fcmToken);
    }).onError((err) {
      if (kDebugMode) {
        print('Error retrieving FCM token: $err');
      }
    });
  }

  void _logToken(String? token) {
    if (kDebugMode) {
      print('FCM Token: $token');
    }
  }
}
