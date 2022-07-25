import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  //Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //Initialization Settings for iOS
    final IOSInitializationSettings initializationSettingsIOS =
         IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      //  onSelectNotification: selectNotification()
    );
  }
//   Future selectNotification(String payload) async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
//     );
// }

  showNotification({int? id, String? body, String? title,int? time}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id!,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: time!)),
        NotificationDetails(
            android: AndroidNotificationDetails('main_channel', 'Main Channel',
                importance: Importance.max, priority: Priority.max),
            iOS: IOSNotificationDetails(
                sound: 'dafault.wav',
                presentAlert: true,
                presentBadge: true,
                presentSound: true)),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
