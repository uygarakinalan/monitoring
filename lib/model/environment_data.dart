// To parse this JSON data, do
//
//     final environmentData = environmentDataFromMap(jsonString);

import 'dart:convert';

List<EnvironmentData> environmentDataFromMap(String str) =>
    List<EnvironmentData>.from(
        json.decode(str).map((x) => EnvironmentData.fromMap(x)));

String environmentDataToMap(List<EnvironmentData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class EnvironmentData {
  EnvironmentData({
    this.istasyonNo,
    this.istasyonAdi,
    this.sicaklik,
    this.basinc,
    this.nem,
    this.ppm,
    this.db,
    this.durum,
    this.gazDirenci,
    this.kaytTarihi,
    this.id,
  });

  String? istasyonNo;
  IstasyonAdi? istasyonAdi;
  String? sicaklik;
  String? basinc;
  String? nem;
  String? ppm;
  String? db;
  String? durum;
  String? gazDirenci;
  DateTime? kaytTarihi;
  int? id;

  factory EnvironmentData.fromMap(Map<String, dynamic> json) => EnvironmentData(
        istasyonNo: json["istasyonNo"],
        istasyonAdi: istasyonAdiValues.map[json["istasyonAdi"]]!,
        sicaklik: json["sicaklik"],
        basinc: json["basinc"],
        nem: json["nem"],
        ppm: json["ppm"],
        db: json["db"],
        durum: json["durum"],
        gazDirenci: json["gazDirenci"],
        kaytTarihi: json["kayıtTarihi"] == null
            ? null
            : DateTime.parse(json["kayıtTarihi"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "istasyonNo": istasyonNo,
        "istasyonAdi": istasyonAdiValues.reverse[istasyonAdi],
        "sicaklik": sicaklik,
        "basinc": basinc,
        "nem": nem,
        "ppm": ppm,
        "db": db,
        "durum": durum,
        "gazDirenci": gazDirenci,
        "kayıtTarihi": kaytTarihi?.toIso8601String(),
        "id": id,
      };
}

enum IstasyonAdi { GAZIMUHTAR, STRING, ISTASYON_ADI_GAZIMUHTAR }

final istasyonAdiValues = EnumValues({
  "gazimuhtar": IstasyonAdi.GAZIMUHTAR,
  "Gazimuhtar": IstasyonAdi.ISTASYON_ADI_GAZIMUHTAR,
  "string": IstasyonAdi.STRING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
