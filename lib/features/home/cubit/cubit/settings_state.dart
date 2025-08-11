part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class DarkModeLight extends SettingsState {}

final class DarkModeNight extends SettingsState {}

final class TrackingOn extends SettingsState {}

final class TrackingOff extends SettingsState {}

final class AppSettings extends SettingsState {
  final bool darkMode;
  final bool tracking;

  AppSettings({required this.darkMode, required this.tracking});
}
