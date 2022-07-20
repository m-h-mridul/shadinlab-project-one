// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/dataModel.dart';
import '../stroage/hivedb.dart';
import 'conntivity_controller.dart';
import 'dart:async';

class HomeController extends GetxController {
  RxList<DataModel> datalist = RxList<DataModel>();
  Hivedb hivedb = Hivedb();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    ConntedtivityController cc = ConntedtivityController.to;
    cc.runingstate.value = true;
    print('value');
    print(cc.connectionStatus.value);
    if (cc.connectionStatus.value != 0) {
      datalist.bindStream(dataget());
      hivedb.putdata(datalist.value);
    } else {
      String value = await hivedb.dataCheak();
      print('Cheak data ' + await hivedb.dataCheak());
      if (value != 'Not find') {
        List<DataModel> data = await hivedb.getdata();
        StreamController<List<DataModel>> _controller =
            StreamController.broadcast();
        _controller.sink.add(data);
        datalist.bindStream(_controller.stream);
      }
    }
  }

  datasentdb({String? title, String? details}) {
    FirebaseFirestore.instance
        .collection('Shadin_lab')
        .add({'title': title, 'details': details});
  }

  dataget() {
    return FirebaseFirestore.instance
        .collection('Shadin_lab')
        .snapshots()
        .asyncMap((event) {
      List<DataModel> ll = [];
      for (var c in event.docs) {
        ll.add(DataModel(details: c.get('details'), title: c.get('title')));
      }
      return ll;
    });
  }
}
