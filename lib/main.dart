import 'dart:async';
import 'dart:ui';

import 'package:background_fetch/background_fetch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:shadinlab_one/services/firebasePushnotification.dart';
import 'package:shadinlab_one/stroage/adapterclass.dart';
import 'package:shadinlab_one/stroage/hivedb.dart';
import 'package:shadinlab_one/services/localNotification.dart';
import 'package:shadinlab_one/view/screen/loadingpage.dart';
import 'Controller/conntivity_controller.dart';
import 'model/modelapidata.dart';
import 'view/screen/homeUI.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  tz.initializeTimeZones();
  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification(); //
  Get.put(ConntedtivityController());

  //for offline data save
  await Hive.initFlutter();
  Hive.registerAdapter(PostDataListAdapter());
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox(Hivedb.boxname);

  //for firebase working
  await Firebase.initializeApp();
  await FirabsePushnotification.registerNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //for app in back ground
  await initializeService();
  // HttpOverrides.global =  MyHttpOverrides();

  runApp(const MyApp());
}

//**foor time calculate sent data in firebase */
String time_new = '';
String time_next = '';
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
  return true;
}

void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) async {
      service.setAsBackgroundService();
      await Firebase.initializeApp();

      CollectionReference users =
          FirebaseFirestore.instance.collection('app life cycle');
      try {
        final periodicTimer = Timer.periodic(
          const Duration(minutes: 10),
          (timer) {
            // Update user about remaining time

            time_new = DateFormat('hh:mm a').format(DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute));
            users.doc(time_new).set({
              'time': time_new,
              'date':
                  '${DateTime.now().day}:${DateTime.now().month}:${DateTime.now().year}',
              'time zone': DateTime.now().timeZoneName,
              'status ': 'when the app is backgroud running',
            }).then((value) => print("details add when app is background"));
          },
        );
      } catch (e) {
        print('Error find data in background  ${e}');
      }
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  // Timer.periodic(const Duration(seconds: 1), (timer) async {
  // if (service is AndroidServiceInstance) {
  //   service.setForegroundNotificationInfo(
  //     title: "My App Service",
  //     content: "Updated at ${DateTime.now()}",
  //   );
  // }

  // /// you can see this log in logcat
  // print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

  // String? device;
  // if (Platform.isAndroid) {
  //   final androidInfo = await deviceInfo.androidInfo;
  //   device = androidInfo.model;
  // }

  // if (Platform.isIOS) {
  //   final iosInfo = await deviceInfo.iosInfo;
  //   device = iosInfo.model;
  // }

  // service.invoke(
  //   'update',
  //   {
  //     "current_date": DateTime.now().toIso8601String(),
  //     "device": device,
  //   },
  // );
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Ladingpage(),
    );
  }
}
