// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shadinlab_one/Controller/conntivity_controller.dart';
import 'package:shadinlab_one/Controller/homecontroller.dart';
import 'package:shadinlab_one/main.dart';
import 'package:shadinlab_one/services/localNotification.dart';
import 'add_data.dart';
import 'audioplayer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  HomeController homeController = Get.put(HomeController());
  ConntedtivityController cc = ConntedtivityController.to;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;
    // time = DateFormat('hh:mm a').format(DateTime.now());
    CollectionReference users =
        FirebaseFirestore.instance.collection('app life cycle');

    if (isBackground) {
      FlutterBackgroundService().invoke('setAsBackground');
      // try {
      //   String time = DateFormat('hh:mm a').format(DateTime(
      //       DateTime.now().year,
      //       DateTime.now().month,
      //       DateTime.now().day,
      //       DateTime.now().hour,
      //       DateTime.now().minute));
      //   users.doc(time).set({
      //     'time': time,
      //     'date':
      //         '${DateTime.now().day}:${DateTime.now().month}:${DateTime.now().year}',
      //     'time zone': DateTime.now().timeZoneName,
      //     'status ': 'when the app is backgroud',
      //   }).then((value) => print("details add when app is background"));
      // } catch (e) {
      //   print(e);
      // }
    }
  }

  //  checkForInitialMessage() async {
  // await Firebase.initializeApp();
  // RemoteMessage? initialMessage =
  //     await FirebaseMessaging.instance.getInitialMessage();

  // if (initialMessage != null) {
  //   PushNotification notification = PushNotification(
  //     title: initialMessage.notification?.title,
  //     body: initialMessage.notification?.body,
  //   );
  //   setState(() {
  //     _notificationInfo = notification;
  //     _totalNotifications++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    RxDouble keyboardcheak = 15.0.obs;
    keyboardcheak.value = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                homeController.onInit();
              },
              icon: Icon(Icons.refresh_outlined)),
          IconButton(
              onPressed: () {
                NotificationService().showNotification(
                    id: 3,
                    title: 'Shadin lab',
                    body: 'shedule tab  notification 10',
                    time: 10);
              },
              icon: Icon(
                Icons.notifications_active,
                size: 18,
              )),
          IconButton(
              onPressed: () {
                NotificationService().showNotification(
                    id: 3,
                    title: 'Shadin lab',
                    body: 'Tab notification',
                    time: 1);
              },
              icon: Icon(
                Icons.notifications,
                size: 18,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          children: [
            Expanded(
                child: Obx(
              () => ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  );
                },
                itemCount: homeController.postlist.value.length,
                itemBuilder: (context, index) {
                  return homeController.postlist.value.isEmpty
                      ? const Text(
                          'No text found ',
                          style: TextStyle(fontSize: 20),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 120, 189, 122),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 9, horizontal: 9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeController.postlist[index].title,
                                style: const TextStyle(fontSize: 24),
                              ),
                              Text(
                                homeController.postlist[index].body,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        );
                },
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: const Text('ADD'),
              onPressed: () {
                Get.to(() => AddData());
              },
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 115, 197, 170),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.6,
                      MediaQuery.of(context).size.height * 0.06),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        tooltip: 'AddData',
        onPressed: () {
          Get.to(() => Audio_playerADD());
        },
        child: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
