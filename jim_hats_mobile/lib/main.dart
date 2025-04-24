// coverage:ignore-file
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:jim_hats_mobile/core/network/firebase/firebase_push_notification_service.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/app.dart';
import 'package:jim_hats_mobile/core/network/httpfix/my_http_overrides.dart';
import 'package:jim_hats_mobile/locator.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await setupDependencies();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebasePushNotificationService = FirebasePushNotificationService();
  try {
  await firebasePushNotificationService.initialize();
    
  } catch (e) {
    if(kDebugMode){
      print(e.toString());
    }
  }
  runApp(MultiBlocProvider(providers: blocProviders, child: const App()));
}
