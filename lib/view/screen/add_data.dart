// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shadinlab_one/model/modelapidata.dart';
import 'package:shadinlab_one/services/api_postdata.dart';
import '../../Controller/homecontroller.dart';

class AddData extends StatelessWidget {
  AddData({Key? key}) : super(key: key);

  TextEditingController title = TextEditingController();
  TextEditingController details = TextEditingController();
  final formkey = GlobalKey<FormState>();
  HomeController homeController = HomeController.to;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {},
                controller: title,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (_) {
                  if (title.text.length < 3) {
                    return 'Please Enter title more then 3 letter';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Title"),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) {},
                controller: details,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: (_) {
                  if (title.text.length < 3) {
                    return 'Please Enter details about more then 3 letter';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Details"),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    Post post = Post(
                        title: title.text.toString(),
                        body: details.text.toString(),
                        id: homeController.datalist.value.length + 1);
                    String code = ApiPostdata.postdata(post);
                    homeController.RestApi_dataget();

                    //** */ for firebase connection
                    // homeController.datasentdb(
                    //     title: title.text.toString(),
                    //     details: details.text.toString());
                    if (code == '200') {
                      title.clear();
                      details.clear();
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    fixedSize: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * 0.06),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
