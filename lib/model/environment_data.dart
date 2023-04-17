// To parse this JSON data, do
//
//     final environmentData = environmentDataFromMap(jsonString);

import 'dart:convert';

class EnvironmentData {
  EnvironmentData({
    this.istasyonNo,
    this.istasyonAdi,
    this.sicaklik,
    this.basinc,
    this.nem,
    this.gazDirenci,
    this.ppm,
    this.db,
    this.durum,
    this.kaytTarihi,
    this.id,
  });

  int? istasyonNo;
  IstasyonAdi? istasyonAdi;
  String? sicaklik;
  String? basinc;
  String? nem;
  String? gazDirenci;
  String? ppm;
  String? db;
  String? durum;
  DateTime? kaytTarihi;
  int? id;

  factory EnvironmentData.fromJson(String str) =>
      EnvironmentData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EnvironmentData.fromMap(Map<String, dynamic> json) => EnvironmentData(
        istasyonNo: json["istasyonNo"],
        istasyonAdi: istasyonAdiValues.map[json["istasyonAdi"]]!,
        sicaklik: json["sicaklik"],
        basinc: json["basinc"],
        nem: json["nem"],
        gazDirenci: json["gazDirenci"],
        ppm: json["ppm"],
        db: json["db"],
        durum: json["durum"],
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
        "gazDirenci": gazDirenci,
        "ppm": ppm,
        "db": db,
        "durum": durum,
        "kayıtTarihi": kaytTarihi?.toIso8601String(),
        "id": id,
      };
}

enum IstasyonAdi { GAZIMUHTAR }

final istasyonAdiValues = EnumValues({"Gazimuhtar": IstasyonAdi.GAZIMUHTAR});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
