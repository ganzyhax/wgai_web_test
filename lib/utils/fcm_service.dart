import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/community/community_screen.dart';
import 'package:wg_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
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

  // Метод для подписки на тему до логина
  Future<void> subscribeToAllTopicBeforeLogin() async {
    try {
      // Подписка на тему "all" до логина
      await _firebaseMessaging.subscribeToTopic("all");
      print("Successfully subscribed to topic 'all' before login");
    } catch (e) {
      print("Failed to subscribe to topic 'all' before login: $e");
    }
  }

  // Полная инициализация после логина
  Future<void> initializeAfterLogin(BuildContext context) async {
    // Запросить разрешение для iOS
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

    // Инициализация локальных уведомлений
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        // Handle the received notification for iOS <10
      },
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log('Notification clicked with payload: ${response.payload}');
        if (response.payload != null) {
          _onNotificationClick(context, response.payload);
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showForegroundNotification(message);
      }
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    handleInitialMessage(context);
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'wg_notification_1',
      'wg_notification_1',
      channelDescription: 'Wg Notification',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
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

  void _handleNotificationNavigation(
      BuildContext context, Map<String, dynamic> notificationBody) {
    if (notificationBody['type'] == 'counselor') {
      BlocProvider.of<MainNavigatorBloc>(context)
        ..add(MainNavigatorChangePage(index: 1, notificationCounselor: true));
      // WeGlobalApp.navigatorKey.currentState?.push(
      //   MaterialPageRoute(
      //     builder: (context) => CommunityScreen(
      //         isCounsulant: true, scrollId: notificationBody['id']),
      //   ),
      // );
    } else if (notificationBody['type'] == 'news') {
      BlocProvider.of<MainNavigatorBloc>(context)
        ..add(MainNavigatorChangePage(
            index: 1, newsScrollId: notificationBody['id']));
      // WeGlobalApp.navigatorKey.currentState?.push(
      //   MaterialPageRoute(
      //     builder: (context) => CommunityScreen(
      //       scrollId: notificationBody['id'],
      //       isCounsulant: false,
      //     ),
      //   ),
      // );
    } else if (notificationBody['type'] == 'growth') {
      BlocProvider.of<MainNavigatorBloc>(context)
        ..add(MainNavigatorChangePage(index: 0));
      // WeGlobalApp.navigatorKey.currentState?.push(
      //   MaterialPageRoute(
      //     builder: (context) => const PersonalGrowthScreen(),
      //   ),
      // );
    }
  }

  Future<void> _onNotificationClick(
      BuildContext context, String? payload) async {
    if (payload != null) {
      log('Notification clicked with payload: $payload');
      Map<String, dynamic> notificationData = parsePayload(payload);
      _handleNotificationNavigation(context, notificationData);
    }
  }

  Map<String, dynamic> parsePayload(String payload) {
    try {
      return jsonDecode(payload);
    } catch (e) {
      log('Failed to parse notification payload: $e');
      return {};
    }
  }
}
