import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resq_map/features/earthquake/http_quake_requests.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();

  factory LocalNotificationService() => _instance;

  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Create notification channel first
      await _createNotificationChannel();

      // Initialize with proper icon
      const AndroidInitializationSettings androidSettings =AndroidInitializationSettings("@mipmap/ic_launcher");

      final InitializationSettings settings = InitializationSettings(
        android: androidSettings,
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,requestBadgePermission: true,requestSoundPermission: true,
        ),
      );

      await _flutterLocalNotificationsPlugin.initialize(
        settings,
        onDidReceiveNotificationResponse: _handleNotificationResponse,
      );

      _isInitialized = true;
    } catch (e) {
      print('⚠️ Notification initialization failed: $e');
      // Consider implementing a retry mechanism
    }
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // Consistent channel ID
      'High Importance Notifications',
      description: 'Channel for emergency alerts',importance: Importance.max,playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'), // Ensure this sound exists
      enableVibration: true,ledColor: Colors.red,enableLights: true,
    );

    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  void _handleNotificationResponse(NotificationResponse response) {
    final action = response.actionId;
    switch (action) {
      case 'safe':
        HttpQuakeRequests.markStatus("Safe");
        break;
      case 'sos':
        HttpQuakeRequests.markStatus("Unsafe");
        break;
      default:
        HttpQuakeRequests.markStatus("Unknown");
      // Handle main notification tap
    }
  }

  @pragma('vm:entry-point')
  Future<void> showEmergencyNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    if (!_isInitialized) await init();

    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: 'Channel for emergency alerts',
            importance: Importance.max,priority: Priority.high,playSound: true,colorized: true,
            color: Colors.blueGrey,ledOnMs: 1000,ledOffMs: 500,enableVibration: true,
            actions: [
              AndroidNotificationAction(
                'safe',
                'I\'m Safe',
                showsUserInterface: true,
              ),
              AndroidNotificationAction(
                'sos',
                'SOS Help',
                showsUserInterface: true,
              ),
            ],
          );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          subtitle: 'Emergency Alert',
          threadIdentifier: 'emergency_alerts',
        ),
      );

      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
      );
    } catch (e) {
      print('⚠️ Failed to show notification: $e');
      await _showFallbackNotification(id, title, body);
    }
  }

  Future<void> _showFallbackNotification(
    int id,
    String? title,
    String? body,
  ) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.high,
          icon: 'ic_notification',
        );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title ?? 'Emergency Alert',
      body ?? 'Please check the app for important information',
      const NotificationDetails(android: androidDetails),
    );
  }
}
