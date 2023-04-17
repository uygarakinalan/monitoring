import 'dart:io';

import 'package:dio/dio.dart';
import 'package:monitoring/model/device.dart';
import 'package:monitoring/model/environment_data.dart';
import 'package:monitoring/service/IFutureService.dart';

import '../model/error_model.dart';

import 'package:http/http.dart' as http;

class FutureService extends IFutureService {
  /*final dio = Dio(
    BaseOptions(
      baseUrl: 'https://opendataapi.gaziantep.bel.tr/api/',
    ),
  );*/

  final dio = Dio();
  dynamic _getDioRequest(String path) async {
    final response = await dio.post(path);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return response.data;
      default:
        return ErrorModel(response.toString());
    }
  }

  dynamic _getDioRequestByGet(String path) async {
    final response = await dio.get(path);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return response.data;
      default:
        return ErrorModel(response.toString());
    }
  }

  @override
  Future<List<Device>> getDeviceList(String path) async {
    final response = await _getDioRequest(path);
    if (response is List) {
      return response.map((e) => Device.fromMap(e)).toList();
    } else {
      throw response;
    }
  }

  @override
  Future<List<EnvironmentData>> getEnvironmentDataList(String path) async {
    final response = await _getDioRequest(path);
    if (response is List) {
      return response.map((e) => EnvironmentData.fromMap(e)).toList();
    } else {
      throw response;
    }
  }

  @override
  Future<List<EnvironmentData>> getEnvironmentDataListByDeviceId(
      String path) async {
    final response = await _getDioRequestByGet(path);
    if (response is List) {
      return response.map((e) => EnvironmentData.fromMap(e)).toList();
    } else {
      throw response;
    }
  }
}
