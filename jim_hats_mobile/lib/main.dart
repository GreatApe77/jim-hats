import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/app.dart';
import 'package:jim_hats_mobile/core/network/httpfix/my_http_overrides.dart';
import 'package:jim_hats_mobile/locator.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await setupDependencies();
  runApp(MultiBlocProvider(providers: blocProviders, child: const App()));
}
