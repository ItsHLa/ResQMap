import 'package:hive/hive.dart';

import 'package:resq_map/features/authentication/utils/key_manager.dart' show KeyManager;

class SettingsService {
  static bool? darkMode;
  static bool? trackLocation;
  static const String _settingsBoxName = 'settingsBox';
  static const String _darkModeKey = 'dark_mode';
  static const String _trackingLocationKey = 'track_location';

  // Cache the box to avoid reopening it multiple times
  static Box? _settingsBox;

  static Future<void> init() async {
    // Hive.registerAdapter(SettingsAdapter());
    await KeyManager.init();
    // Initialize the box during init
    _settingsBox = await _openSettingsBox();
  }

  static Future<Box> _openSettingsBox() async {
    if (_settingsBox != null && _settingsBox!.isOpen) {
      return _settingsBox!;
    }
    final key = await KeyManager.getOrCreateKey();
    _settingsBox = await Hive.openBox(
      _settingsBoxName,
      encryptionCipher: HiveAesCipher(key),
    );
    return _settingsBox!;
  }

  static Future<void> saveDarkMode({required bool darkMode}) async {
    try {
      final box = await _openSettingsBox();
      await box.put(_darkModeKey, darkMode);
    } catch (e) {
      // Consider adding proper error logging here
      rethrow;
    }
  }

  static Future<void> saveTrackingLocation({required bool trackingLocation}) async {
    try {
      final box = await _openSettingsBox();
      await box.put(_trackingLocationKey, trackingLocation);
    } catch (e) {
      // Consider adding proper error logging here
      rethrow;
    }
  }

  static Future<bool?> getDarkMode() async {
    try {
      final box = await _openSettingsBox();
      return box.get(_darkModeKey) as bool?;
    } catch (e) {
      // Consider adding proper error logging here
      return null;
    }
  }

  static Future<bool?> getTrackingLocation() async {
    try {
      final box = await _openSettingsBox();
      return box.get(_trackingLocationKey) as bool?;
    } catch (e) {
      // Consider adding proper error logging here
      return null;
    }
  }

  static Future<void> clearAllData() async {
    try {
      final box = await _openSettingsBox();
      await box.clear();
    } catch (e) {
      // Consider adding proper error logging here
      rethrow;
    }
  }
}