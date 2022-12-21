import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification/secondpage.dart';

class NotificationTools {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidNotificationDetails _androidNotificationDetails;
  late DarwinNotificationDetails _iOSNotificationDetails;
  late NotificationDetails _notificationDetails;


  init(context) {
    _androidNotificationDetails = const AndroidNotificationDetails(
        'channel id', 'channel adi',
        channelDescription: "channel açıklaması",
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound("noti"),
        playSound: true,
        importance: Importance.max);
    _iOSNotificationDetails =
        const DarwinNotificationDetails(presentSound: true, sound: 'noti.wav');
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var _android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var _iOS = const DarwinInitializationSettings(requestSoundPermission: true);
    var _initSetttings = InitializationSettings(android: _android, iOS: _iOS);
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    _flutterLocalNotificationsPlugin.initialize(
      _initSetttings,
      onDidReceiveNotificationResponse: (details) async {
        var payload = details.payload;
        if (details.payload != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SecondPage(payload!)));
        }
      },
    );
    _notificationDetails = NotificationDetails(
        android: _androidNotificationDetails, iOS: _iOSNotificationDetails);
  }

  _requestIOSPermission() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: false,
          badge: true,
          sound: true,
        );
  }

  Future<void> showInstantNotification() async {
    await _flutterLocalNotificationsPlugin.show(
      1,
      'instant title',
      'instant body',
      _notificationDetails,
    );
  }

  Future<void> showPeriodicNotification() async {
    await _flutterLocalNotificationsPlugin.periodicallyShow(0, 'periodic title',
        'periodic body', RepeatInterval.everyMinute, _notificationDetails,
        androidAllowWhileIdle: true);
  }

  Future<void> showSchenduleNotification(int second) async {
    var time = DateTime(0, 0, 0, 0, second);
    await _flutterLocalNotificationsPlugin.schedule(
        0, 'repeating title', 'repeating body', time, _notificationDetails,
        androidAllowWhileIdle: true);
  }

  Future<void> showPayloadNotification(payload) async {
    var time = DateTime(0, 0, 0, 0, 5);
    await _flutterLocalNotificationsPlugin.schedule(
        0, 'payload title', 'repeating body', time, _notificationDetails,
        androidAllowWhileIdle: true, payload: payload);
  }
}
