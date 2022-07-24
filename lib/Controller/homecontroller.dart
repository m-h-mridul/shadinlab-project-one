// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shadinlab_one/services/api_service.dart';
import '../model/dataModel.dart';
import '../model/modelapidata.dart';
import '../stroage/hivedb.dart';
import 'conntivity_controller.dart';
import 'dart:async';

class HomeController extends GetxController {
  RxList<DataModel> datalist = RxList<DataModel>();
  RxList<Post> postlist = RxList<Post>();
  Hivedb hivedb = Hivedb();
  ConntedtivityController? cc;
  static HomeController to = Get.find<HomeController>();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    try {
      cc = ConntedtivityController.to;
      cc!.runingstate.value = true;
      if (cc!.connectionStatus.value == 1 || cc!.connectionStatus.value == 2) {
        //*for firebase api
        // datalist.bindStream(dataget());
        // hivedb.putdata(datalist.value);
        //**for rest api data */
        await RestApi_dataget();
        await restapi_getdatafromhive();

      } else {
        //**for rest api  */
        await restapi_getdatafromhive();

        ///**for  firebase database */
        // String value = await hivedb.dataCheak(Hivedb.postlistname);
        // if (value != 'Not find') {
        //   List<DataModel> data = await hivedb.getdata();
        //   StreamController<List<DataModel>> _controller =
        //       StreamController.broadcast();
        //   _controller.sink.add(data);
        //   datalist.bindStream(_controller.stream);
        // }

      }
    } catch (e) {
      print('error find from dataget');
      print(e);
    }
  }

  firbase_datasentdb({String? title, String? details}) {
    FirebaseFirestore.instance
        .collection('Shadin_lab')
        .add({'title': title, 'details': details});
  }

  firebase_dataget() {
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

  RestApi_dataget() async {
    String data = await ApiService.getdata();
    UserSentInfo userinfo = userRegistationInfoFromMap(data);
    List<Post> postdata = userinfo.posts;
    //**rs list */
    postlist.clear();
    postlist.value.addAll(userinfo.posts);
    hivedb.putrestpailist(userinfo.posts);
    postlist.refresh();
  }

  restapi_getdatafromhive() async {
    print('hive data get');
    if (!hivedb.dataCheak()) {
      List<Post> data = await hivedb.restpaigetdata();
      print(data[3].body);
      postlist.clear();
      postlist.value.addAll(data);
      postlist.refresh();
    } else {
      print('Data cannot find in hive');
    }
  }
}
