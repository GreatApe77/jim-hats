import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/app.dart';
import 'package:jim_hats_mobile/locator.dart';

void main(List<String> args)async {
  await setupDependencies();
  runApp(App());
}