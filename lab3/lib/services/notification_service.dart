import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../screens/recipe_details.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> init(BuildContext context) async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _localNotifications.initialize(
      const InitializationSettings(android: androidSettings),
      onDidReceiveNotificationResponse: (details) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailedRecipe(recipeId: "")),
        );
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailedRecipe(recipeId: "")),
      );
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailedRecipe(recipeId: "")),
        );
      }
    });
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
        'default_channel', 'General Notifications',
        importance: Importance.high, priority: Priority.high);

    const platformDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      platformDetails,
    );
  }

  static Future<String?> getToken() async {
    final token = await _messaging.getToken();
    print("FCM Token: $token");
    return token;
  }
}
