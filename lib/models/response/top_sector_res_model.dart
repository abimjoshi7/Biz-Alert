// To parse this JSON data, do
//
//     final topSectorModel = topSectorModelFromJson(jsonString);

import 'dart:convert';

TopSectorModel topSectorModelFromJson(String str) =>
    TopSectorModel.fromJson(json.decode(str));

String topSectorModelToJson(TopSectorModel data) => json.encode(data.toJson());

class TopSectorModel {
  TopSectorModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  factory TopSectorModel.fromJson(Map<String, dynamic> json) => TopSectorModel(
        status: json["status"],
        message: json["message"],
        dataCollection: List<DataCollection>.from(
            json["dataCollection"].map((x) => DataCollection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "dataCollection":
            List<dynamic>.from(dataCollection.map((x) => x.toJson())),
      };
}

class DataCollection {
  DataCollection({
    required this.sectorName,
    required this.turnover,
    required this.totalTradedVolume,
    required this.date,
  });

  final String sectorName;
  final String turnover;
  final int totalTradedVolume;
  // final Date? date;
  final String? date;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        sectorName: json["SectorName"],
        turnover: json["Turnover"],
        totalTradedVolume: json["TotalTradedVolume"],
        // date: dateValues.map[json["date"]],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "SectorName": sectorName,
        "Turnover": turnover,
        "TotalTradedVolume": totalTradedVolume,
        // "date": dateValues.reverse[date],
        "date": date,
      };
}

// enum Date { THE_20211214123200 }

// final dateValues = EnumValues({"2021/12/14 12:32:00": Date.THE_20211214123200});

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
