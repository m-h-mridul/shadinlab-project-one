// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../services/api_postdata.dart';
import '../../services/image_get.dart';

class Image_view extends StatelessWidget {
  const Image_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await openImages();
                },
                style: ElevatedButton.styleFrom(
                    //primary: Colors.purple,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                        MediaQuery.of(context).size.height * 0.06),
                    textStyle: const TextStyle(
                      fontSize: 20,
                    )),
                child: Text("Open Images"),
              ),
              Divider(),
              Text("Picked Images:"),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Obx(
                  () => imagefiles!.isNotEmpty
                      ? Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20),
                                  itemCount: imagefiles!.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Card(
                                        child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.file(
                                          File(imagefiles![index].path)),
                                    ));
                                  }),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                ApiPostdata.datasent_start.value = true;
                                await ApiPostdata.imagesetRestApi();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.purple,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      MediaQuery.of(context).size.height *
                                          0.06),
                                  textStyle: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                              child: Row(
                                children: [
                                  Expanded(child: Text("Sent Images")),
                                  Visibility(
                                    child: CircularProgressIndicator(),
                                    visible: ApiPostdata.datasent_start.value,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      :const Text('image cannot selected'),
                ),
              ),
              Obx(() => Text(ApiPostdata.progress_only_rx.value)),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => CircularProgressIndicator(
                  strokeWidth: 20,
                  value: double.parse(ApiPostdata.progress.value.toString()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
