// ignore_for_file: file_names

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class FirabsePushnotification {
  static registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    FirebaseMessaging _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        PushNotification notificationInfo = PushNotification(
          title: message.notification?.title ?? " form given",
          body: message.notification?.body ?? " form given",
        );

        await flutterLocalNotificationsPlugin.zonedSchedule(
            2,
            message.notification?.title ?? " form given",
            message.notification?.body ?? " form given",
            tz.TZDateTime.now(tz.local).add(Duration(seconds: 1)),
            NotificationDetails(
              android: AndroidNotificationDetails(
                  'main_channel', 'Main Channel',
                  importance: Importance.max, priority: Priority.max),
            ),
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            androidAllowWhileIdle: true);
        // showSimpleNotification(
        //   Text(notificationInfo.title!),
        //   leading: NotificationBadge(totalNotifications: _totalNotifications),
        //   subtitle: Text(notificationInfo.body!),
        //   background: Colors.cyan.shade700,
        //   duration: Duration(seconds: 2),
        // );
      });

      print('User granted permission');
      // TODO: handle the received notifications
    } else {
      print('User declined or has not accepted permission');
    }
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}
