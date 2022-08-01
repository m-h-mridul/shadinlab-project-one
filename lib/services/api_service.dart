// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:shadinlab_one/model/modelapidata.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static getHeaders() {
    return {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'application/json',
      'Authorization': "**",
      'User-Aagent': "4.1.0;android;6.0.1;default;A001",
      "HZUID": "2",
    };
  }

  static Dio dio = Dio(
    BaseOptions(
        baseUrl: "http://donation.shadhintech.com/",
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: getHeaders(),
        responseType: ResponseType.plain,
        setRequestContentTypeWhenNoPayload: true),
  );

  static Dio d = Dio();

  static Future<dynamic> getdata() async {
    try {
      var response = await dio.get("api/posts_list");
      String data = response.data.toString();
      return data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      print('Error finds');
      print(e);
    }
  }

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
      if (response.statusCode != 200) {
        Get.snackbar('Errors find ', '${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 230, 103, 94),
            borderRadius: 12,
            margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
            colorText: Colors.white);
      }
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      print('Error find When api data sent');
      print(e);
    }
  }
}
