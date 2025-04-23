// coverage:ignore-file
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/app.dart';
import 'package:jim_hats_mobile/core/network/httpfix/my_http_overrides.dart';
import 'package:jim_hats_mobile/locator.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  await setupDependencies();
  runApp(MultiBlocProvider(providers: blocProviders, child: const App()));
}
