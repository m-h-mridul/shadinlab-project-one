// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shadinlab_one/services/image_get.dart';
import 'package:shadinlab_one/view/widget/snakeber.dart';
import '../model/modelapidata.dart';
import 'package:http/http.dart' as http;

class ApiPostdata {
  static RxBool datasent_start = false.obs;
  static RxString progress = '0'.obs;
  static RxString progress_only_rx = '0'.obs;
  static StreamController<String> progress_value =
      StreamController<String>.broadcast();
  StreamSubscription<String>? progress_value_subscription;
  static RxList bytes = RxList();

  //***data sent n api  */
  static postdata(Post data) async {
    Map<String, dynamic> data2 = {
      'id': data.id.toString(),
      'title': data.title,
      'body': data.body,
    };
    try {
      var url = Uri.parse('http://donation.shadhintech.com/api/posts_add');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: data2, // data.toMap(),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        view_status_succesful(
            title: 'Succesful', subtitle: 'Data sent successfully done');
      } else {
        view_status_errors(
            title: 'Error find',
            subtitle: 'The errors is ${response.statusCode}');
      }
      return response.statusCode;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      print('Error find When api data sent \n ${e}');
    }
  }

  //**image sent */
  static imagesetRestApi() async {
    // String urlName = 'http://donation.shadhintech.com/api/upload_files';
    String mainurl = 'donation.shadhintech.com';
    String endpoint = '/api/upload_files';
    Uri url = Uri.http(mainurl, endpoint, {"upload_files[]": ''});

    try {
      List<http.MultipartFile> newListgenerator2 = [];
      for (int i = 0; i < imagefiles!.length; i++) {
        var multipartFile = await http.MultipartFile.fromPath(
            "upload_files[]", imagefiles![i].path,
            filename: imagefiles![i].path.split('/').last);
        newListgenerator2.add(multipartFile);
      }
      var request = http.MultipartRequest("POST", url);
      request.files.addAll(newListgenerator2);
      FormData fromdata = FormData.fromMap(
        {"upload_files[]": newListgenerator2},
      );
      // var response=await Dio().post(
      //   mainurl + endpoint,
      //   data: fromdata,
      //   onSendProgress: (count, total) {
      //     print('count $count');
      //     print('total $total');
      //   },
      // );
       int downloadLength = 0;
       int mainlength = request.contentLength;
      request.send().asStream().listen((newBytes) async {
        downloadLength = downloadLength + await newBytes.stream.length;
        print(downloadLength);
        progress_value
            .add(((downloadLength / mainlength) * 100).toStringAsFixed(5));
        progress_only_rx.value = '';
        progress_only_rx.value =
            ((downloadLength / mainlength) * 100).toStringAsFixed(5);
        progress_value.stream.listen((event) {
          progress.value = event;
        });
      }, onDone: () {
        progress_only_rx.close();
        datasent_start.value = false;
        view_status_succesful(
            title: 'Succesful', subtitle: 'Image sent successfully done');
      });
      // if (response.statusCode == 200) {
      //   datasent_start.value = false;
      //   view_status_succesful(
      //       title: 'Succesful', subtitle: 'Image sent successfully done');
      // } else {
      //   datasent_start.value = false;
      //   view_status_errors(
      //       title: 'Error find ',
      //       subtitle: 'The errors is ${response.statusCode}');
      // }
    } catch (e) {
      datasent_start.value = false;
      view_status_errors(title: 'Error find ', subtitle: 'The errors is $e');
      print('In image sent method $e');
    }
  }
}
