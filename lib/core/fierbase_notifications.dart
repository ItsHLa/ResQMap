// import 'package:firebase_messaging/firebase_messaging.dart';

// class FirebaseNotificationService {
//   Future<void> subscribeToTopic(String topic) async {
//     await FirebaseMessaging.instance.subscribeToTopic(topic);
//     print('Subscribed to topic: $topic');
//   }

//   Future<void> unsubscribeFromTopic(String topic) async {
//     await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
//     print('Unsubscribed from topic: $topic');
//   }

//   void onOpen(RemoteMessage message) {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('تم فتح الإشعار: ${message.notification?.title}');
//     });
//   }

//   void onForeground(RemoteMessage message) {
    
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print('تم استقبال إشعار جديد: ${message.notification?.body}');
    
//   });
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    await requestNotificationPermissions();
    await _setupInteractedMessage();
    _setupForegroundMessageHandler();
    _setupBackgroundMessageHandler();
  }

  static Future<void> requestNotificationPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    print('Notification permission status: ${settings.authorizationStatus}');
  }

  static Future<void> _setupInteractedMessage() async {
    // معالجة الإشعارات عند فتح التطبيق من خلال الإشعار
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotification(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);
  }

  static void _setupForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');
      
      // هنا يمكنك تنفيذ أي إجراءات عند استقبال الإشعار في الواجهة الأمامية
      // دون الحاجة لعرض إشعار محلي
    });
  }

  static void _setupBackgroundMessageHandler() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message:');
    print('Message ID: ${message.messageId}');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');
    
    // هنا يمكنك:
    // 1. حفظ البيانات في قاعدة البيانات المحلية
    // 2. تنفيذ أي مهام أخرى مطلوبة
    // دون الحاجة لعرض إشعار محلي
  }

  static void _handleNotification(RemoteMessage message) {
    print('Notification opened:');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');
    
    // هنا يمكنك التنقل للشاشة المناسبة بناء على محتوى الإشعار
  }

  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Successfully subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic $topic: $e');
      throw Exception('Failed to subscribe to topic');
    }
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Successfully unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic $topic: $e');
      throw Exception('Failed to unsubscribe from topic');
    }
  }

  static Future<String?> getDeviceToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');
      return token;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }
}