import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shadinlab_one/services/firebasePushnotification.dart';
import 'package:shadinlab_one/stroage/adapterclass.dart';
import 'package:shadinlab_one/stroage/hivedb.dart';
import 'package:shadinlab_one/services/localNotification.dart';
import 'Controller/conntivity_controller.dart';
import 'model/modelapidata.dart';
import 'view/screen/homeUI.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification(); //
  Get.put(ConntedtivityController());
  await Hive.initFlutter();
  Hive.registerAdapter(PostDataListAdapter());
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox(Hivedb.boxname);
  await Firebase.initializeApp();
  await FirabsePushnotification.registerNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // HttpOverrides.global =  MyHttpOverrides();
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

