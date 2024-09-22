import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMService {
  static final FCMService _instance = FCMService._internal();

  factory FCMService() {
    return _instance;
  }

  FCMService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
      return;
    }
    String? a = await getToken();
    log(a.toString() + ' ala');
    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Notification received: ${message.notification?.title}');
      }
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    print('Handling background message: ${message.messageId}');
  }

  void handleInitialMessage() async {
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      print("App opened from a terminated state due to a notification:");
      if (initialMessage.notification != null) {
        print('Notification: ${initialMessage.notification?.title}');
        print(
            "Notification: ${initialMessage.notification?.title}, ${initialMessage.notification?.body}");
      }
    }
  }

  void configureNotificationActions(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("User tapped on a notification:");
      if (message.notification != null) {
        print('Notification: ${message.notification?.title}');
        print(
            "Notification: ${message.notification?.title}, ${message.notification?.body}");
        // You can navigate the user to a specific screen
        // Navigator.pushNamed(context, '/notification', arguments: message);
      }
    });
  }
}
