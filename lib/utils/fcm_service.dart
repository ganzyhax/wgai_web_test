import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wg_app/app/screens/community/community_screen.dart';
import 'package:wg_app/app/screens/personal_growth/personal_growth_screen.dart';

class FCMService {
  static final FCMService _instance = FCMService._internal();

  factory FCMService() {
    return _instance;
  }

  FCMService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Request permission for iOS
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

    // Initialize local notifications for showing foreground notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // Change the icon

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize the plugin and handle notification taps
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Log when a notification is clicked
      log('Notification clicked with payload: ${response.payload}');

      if (response.payload != null) {
        print('Notification payload: ${response.payload}');
      }
    });

    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print(
            'Notification received in foreground: ${message.notification?.title}');
        _showForegroundNotification(message);
      }
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    // Handle notification tap when app is opened from terminated state
    // Replace `context` with the actual context from your app
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'wg_notification_1', // Replace with your channel ID
      'wg_notification_1', // Replace with your channel name
      channelDescription: 'Wg Notification', // Add a description
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.notification?.body, // Pass additional info as payload
    );
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    print('Handling background message: ${message.messageId}');
  }

  void handleInitialMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      print("App opened from a terminated state due to a notification:");
      if (initialMessage.notification != null) {
        print('Notification: ${initialMessage.notification?.title}');
        _handleNotificationNavigation(context, initialMessage.data);
      }
    }
  }

  void configureNotificationActions(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        _handleNotificationNavigation(context, message.data);
      }
    });
  }

  void _handleNotificationNavigation(BuildContext context, notificationBody) {
    // Handle navigation based on the notification body

    if (notificationBody['type'] == 'counselor') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CommunityScreen(
                  isCounsulant: true,
                )),
      );
    } else if (notificationBody['type'] == 'news') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CommunityScreen(
                  isCounsulant: false,
                )),
      );
    }
  }

  // Callback for handling notification tap
  Future<void> _onNotificationClick(
      BuildContext context, String? payload) async {
    if (payload != null) {
      log('Notification clicked with payload: $payload'); // Log the click action
      _handleNotificationNavigation(context, payload);
    }
  }
}
