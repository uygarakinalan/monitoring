import 'dart:io';

import 'package:dio/dio.dart';
import 'package:monitoring/model/device.dart';

class ApiHelper {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://opendataapi.gaziantep.bel.tr/api/',
    ),
  );

  void getHttp() async {
    final dio = Dio();
    final response = await dio.get('https://pub.dev');
    print(response.data);
  }

  // Future<List<Device>> getDeviceList() {}

  void getUser({required String id}) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      final response = await dio.post('Environment/GetDeviceList',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));

      print("Response:");
      print("Status:\n${response.statusCode}");
      print("Header:\n${response.headers}");
      print("Data:\n${response.data}");
    } catch (e) {
      print("Exception: $e");
    }
  }
}
