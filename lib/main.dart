import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shadinlab_one/stroage/adapterclass.dart';
import 'package:shadinlab_one/stroage/hivedb.dart';
import 'Controller/conntivity_controller.dart';
import 'model/modelapidata.dart';
import 'view/screen/homeUI.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ConntedtivityController());
  await Hive.initFlutter();
  Hive.registerAdapter(PostDataListAdapter());
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox(Hivedb.boxname);
  await Firebase.initializeApp();
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

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
