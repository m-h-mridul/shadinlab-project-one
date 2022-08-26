// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:dio/dio.dart';

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

  //**get data from api  */
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

  
}
