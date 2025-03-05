import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData light({required TextTheme textTheme}) {
    return ThemeData.from(
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.redAccent,
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData dark({required TextTheme textTheme}) {
    ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.redAccent,
      brightness: Brightness.dark,
    );

    return ThemeData.from(
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      colorScheme: colorScheme,
    );
  }
}
