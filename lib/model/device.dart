// To parse this JSON data, do
//
//     final device = deviceFromMap(jsonString);

import 'dart:convert';

class Device {
  Device({
    this.deviceId,
    this.deviceDetail,
    this.deviceDescription,
    this.deviceType,
    this.longtitude,
    this.latitude,
    this.addedDate,
    this.updatedDate,
  });

  int? deviceId;
  String? deviceDetail;
  String? deviceDescription;
  int? deviceType;
  String? longtitude;
  String? latitude;
  DateTime? addedDate;
  DateTime? updatedDate;

  factory Device.fromJson(String str) => Device.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Device.fromMap(Map<String, dynamic> json) => Device(
        deviceId: json["deviceId"],
        deviceDetail: json["deviceDetail"],
        deviceDescription: json["deviceDescription"],
        deviceType: json["deviceType"],
        longtitude: json["longtitude"],
        latitude: json["latitude"],
        addedDate: json["addedDate"] == null
            ? null
            : DateTime.parse(json["addedDate"]),
        updatedDate: json["updatedDate"] == null
            ? null
            : DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toMap() => {
        "deviceId": deviceId,
        "deviceDetail": deviceDetail,
        "deviceDescription": deviceDescription,
        "deviceType": deviceType,
        "longtitude": longtitude,
        "latitude": latitude,
        "addedDate": addedDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
      };
}
