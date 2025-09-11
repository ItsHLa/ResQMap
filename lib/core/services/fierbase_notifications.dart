import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:resq_map/core/services/local_notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FirebaseNotificationService.backgroundMessageHandler(message);
}

class FirebaseNotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final LocalNotificationService _localNotificationService =
      LocalNotificationService();

  /// Initialize all notification services~
  static Future<void> initialize() async {
    try {
      await _localNotificationService.init();
      await _requestNotificationPermissions();

      
      _setUpMessageHandlers();
      await _handleInitialNotification();
    } catch (e) {
      print('Error initializing FirebaseNotificationService: $e');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    final localNotificationService = LocalNotificationService();
    await localNotificationService.init();
    await localNotificationService.showEmergencyNotification(
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }

  static void _setUpMessageHandlers() {
    FirebaseMessaging.onMessage.listen((message) {
      _localNotificationService.showEmergencyNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Notification opened: ${message.messageId}');
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<void> _requestNotificationPermissions() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  
  }

  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _fcm.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic: $e');
    }
  }

  static Future<void> unSubscribeFromTopic(String topic) async {
    try {
      await _fcm.unsubscribeFromTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic: $e');
    }
  }
  

  static Future<void> _handleInitialNotification() async {
    final message = await _fcm.getInitialMessage();
    if (message != null) {
      print('App opened from notification: ${message.messageId}');
    }
  }
}
