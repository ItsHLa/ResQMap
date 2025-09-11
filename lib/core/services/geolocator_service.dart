import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

enum LocationServiceStatus {
  always,
  enabled,
  disabled,
  permissionDenied,
  permissionDeniedForever,
}

abstract class GeolocatorService {
  static StreamSubscription<Position>? _positionStreamSubscription;

  /// Checks and requests location permissions.
  static Future<LocationServiceStatus> checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationServiceStatus.disabled;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationServiceStatus.permissionDenied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationServiceStatus.permissionDeniedForever;
    }
    // await Geolocator.openAppSettings();
    return LocationServiceStatus.enabled;
  }

  static Future<String> requestAlwaysLocation(BuildContext context) async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return "Location services are disabled. Please enable GPS.";
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Location permission denied.";
      }
    }

    // 4. إذا كان الإذن مؤقتًا (WhileInUse)
    if (permission == LocationPermission.whileInUse) {
      // عرض حوار توجيهي
      bool? openSettings = await showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text("Background Access Required"),
              content: const Text(
                "For background tracking, please select 'Always Allow' in app settings.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text("Open Settings"),
                ),
              ],
            ),
      );

      if (openSettings == true) {
        await Geolocator.openAppSettings();
        return "Please change permission to 'Always' and restart the app.";
      }
      return "Background permission not granted.";
    }

    // 5. إذا كان الإذن دائمًا
    if (permission == LocationPermission.always) {
      return "Always permission already granted.";
    }

    return "Unknown permission state.";
  }

  /// Gets the current position.
  static Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation
    );
  }

  /// Gets the last known position.
  static Future<Position?> getLastKnownPosition({
    bool forceAndroidLocationManager = false,
  }) async {
    try {
      return await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: forceAndroidLocationManager,
      );
    } catch (e) {
      throw Exception('Failed to get last known position: $e');
    }
  }

  /// Starts continuous location tracking.
  static Future<void> startTracking({
    required BuildContext context,
    void Function(Position)? onData,
    LocationAccuracy accuracy = LocationAccuracy.bestForNavigation,
    int distanceFilter =  100,
  }) async {
    print("start tracking");
    requestAlwaysLocation(context);
    LocationSettings androidLocationSettings = AndroidSettings(
      accuracy: accuracy,
      foregroundNotificationConfig: ForegroundNotificationConfig(
        enableWakeLock: true,
        notificationTitle: "Location fetching in background",
        notificationText: "Your Currect Location is listened in background",
      ),
      distanceFilter: distanceFilter,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: androidLocationSettings,
    ).listen(onData);
  }

  /// Stops location tracking.
  static void stopTracking() {
    print("stop tracking");
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }
}
