part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsDataLoadInProgress extends SettingsState {}

final class SettingsDataLoadSuccess extends SettingsState {
  final LoggedUser loggedUser;

  SettingsDataLoadSuccess({required this.loggedUser});
}

final class SettingsDataFailed extends SettingsState {}
