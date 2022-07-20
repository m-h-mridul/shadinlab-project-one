import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadinlab_one/Controller/homecontroller.dart';
import '../Controller/conntivity_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeController homeController = Get.put(HomeController());
  ConntedtivityController cc = ConntedtivityController.to;

  TextEditingController title = TextEditingController();
  TextEditingController details = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RxDouble keyboardcheak = 15.0.obs;

    keyboardcheak.value = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          children: [
            Expanded(
                child: Obx(
              () => ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Theme.of(context).primaryColor,
                  );
                },
                itemCount: homeController.datalist.value.length,
                itemBuilder: (context, index) {
                  return homeController.datalist.value.length == 0
                      ? const Text(
                          'No text found ',
                          style: const TextStyle(fontSize: 20),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 120, 189, 122),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 9, horizontal: 9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeController.datalist[index].title,
                                style: const TextStyle(fontSize: 24),
                              ),
                              Text(
                                homeController.datalist[index].details,
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
            TextField(
              onChanged: (value) {},
              controller: title,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Title"),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {},
              controller: details,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Details"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          tooltip: 'AddData',
          onPressed: () {
            if (cc.connectionStatus.value == 0) {
              Get.snackbar('Connection Error!', 'Please try again later!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  borderRadius: 12,
                  margin: EdgeInsets.only(bottom: 20, left: 12, right: 12),
                  colorText: Colors.white);
            } else {
              homeController.datasentdb(
                  title: title.text.toString(),
                  details: details.text.toString());
              title.clear();
              details.clear();
            }
          },
          child: Obx(
            () => keyboardcheak.value == 0.0
                ? Icon(Icons.add)
                : Icon(
                    Icons.arrow_forward_ios,
                  ),
          )),
    );
  }
}
