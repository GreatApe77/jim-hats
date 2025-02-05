part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}


final class ThemeDark extends ThemeState{}

final class ThemeLight extends ThemeState{}