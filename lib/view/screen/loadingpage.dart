import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadinlab_one/Controller/auth_controller.dart';
import 'package:shadinlab_one/view/screen/audioplayer.dart';
import 'package:shadinlab_one/view/screen/authui.dart';
import 'package:shadinlab_one/view/screen/homeUI.dart';
import 'package:shadinlab_one/view/screen/image_view.dart';


class Ladingpage extends StatelessWidget {
  Ladingpage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('TO DO'),
              onPressed: () {
                Get.to(() => const MyHomePage());
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.06),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 15,
            ),
            ElevatedButton(
              child: const Text('Audio play'),
              onPressed: () {
                Get.to(() => Audio_playerADD());
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.06),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 15,
            ),
            ElevatedButton(
              child: const Text('Auth add'),
              onPressed: () {
                AuthController controller=Get.put(AuthController());
                Get.to(() => AuthPages());
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.06),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 15,
            ),
            ElevatedButton(
              child: const Text('Image sent rest api'),
              onPressed: () {
                Get.to(() => Image_view());
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.06),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 15,
            ),
          ]),
    )));
  }
}
