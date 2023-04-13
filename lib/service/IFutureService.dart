import 'package:monitoring/model/device.dart';

import '../model/environment_data.dart';

abstract class IFutureService {
  Future<List<Device>> getDeviceList(String path);
  Future<List<EnvironmentData>> getEnvironmentDataList(String path);
}
