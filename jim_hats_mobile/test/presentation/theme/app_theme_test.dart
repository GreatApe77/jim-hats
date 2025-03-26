import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/theme/app_theme.dart';

void main() {
  test(
    'Should create light Theme',
    () {
      final theme = AppTheme.light(textTheme: TextTheme());
      expect(theme.colorScheme.brightness, Brightness.light);
    },
  );
  test(
    'Should create dark Theme',
    () {
      final theme = AppTheme.dark(textTheme: TextTheme());
      expect(theme.colorScheme.brightness, Brightness.dark);
    },
  );
}
