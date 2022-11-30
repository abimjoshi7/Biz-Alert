// To parse this JSON data, do
//
//     final topGainersModel = topGainersModelFromJson(jsonString);

import 'dart:convert';

TopGainersModel topGainersModelFromJson(String str) =>
    TopGainersModel.fromJson(json.decode(str));

String topGainersModelToJson(TopGainersModel data) =>
    json.encode(data.toJson());

class TopGainersModel {
  TopGainersModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  factory TopGainersModel.fromJson(Map<String, dynamic> json) =>
      TopGainersModel(
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
    required this.symbol,
    required this.ltp,
    required this.priceChange,
    required this.percentageChange,
    required this.high,
    required this.low,
    required this.open,
    required this.qty,
    required this.ltv,
    required this.turnOver,
    required this.dateTime,
    required this.order,
  });

  final String symbol;
  final double ltp;
  final double priceChange;
  final double percentageChange;
  final double high;
  final double low;
  final double open;
  final int qty;
  final int ltv;
  final double turnOver;
  final String dateTime;
  final int order;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        symbol: json["Symbol"],
        ltp: json["Ltp"].toDouble(),
        priceChange: json["PriceChange"].toDouble(),
        percentageChange: json["PercentageChange"].toDouble(),
        high: json["High"].toDouble(),
        low: json["Low"].toDouble(),
        open: json["Open"].toDouble(),
        qty: json["Qty"],
        ltv: json["Ltv"],
        turnOver: json["TurnOver"].toDouble(),
        dateTime: json["DateTime"],
        order: json["Order"],
      );

  Map<String, dynamic> toJson() => {
        "Symbol": symbol,
        "Ltp": ltp,
        "PriceChange": priceChange,
        "PercentageChange": percentageChange,
        "High": high,
        "Low": low,
        "Open": open,
        "Qty": qty,
        "Ltv": ltv,
        "TurnOver": turnOver,
        "DateTime": dateTime,
        "Order": order,
      };
}


















// // To parse this JSON data, do
// //
// //     final topGainersModel = topGainersModelFromJson(jsonString);

// import 'dart:convert';

// TopGainersModel topGainersModelFromJson(String str) =>
//     TopGainersModel.fromJson(json.decode(str));

// String topGainersModelToJson(TopGainersModel data) =>
//     json.encode(data.toJson());

// class TopGainersModel {
//   TopGainersModel({
//     required this.status,
//     required this.message,
//     required this.dataCollection,
//   });

//   final String status;
//   final String message;
//   final List<DataCollection> dataCollection;

//   factory TopGainersModel.fromJson(Map<String, dynamic> json) =>
//       TopGainersModel(
//         status: json["status"],
//         message: json["message"],
//         dataCollection: List<DataCollection>.from(
//             json["dataCollection"].map((x) => DataCollection.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "dataCollection":
//             List<dynamic>.from(dataCollection.map((x) => x.toJson())),
//       };
// }

// class DataCollection {
//   DataCollection({
//     required this.symbol,
//     required this.ltp,
//     required this.priceChange,
//     required this.percentageChange,
//     required this.high,
//     required this.low,
//     required this.open,
//     required this.qty,
//     required this.ltv,
//     required this.turnOver,
//     required this.dateTime,
//     required this.order,
//   });

//   final String symbol;
//   final double ltp;
//   final double priceChange;
//   final double percentageChange;
//   final double high;
//   final double low;
//   final double open;
//   final int qty;
//   final int ltv;
//   final double turnOver;
//   final DateTime? dateTime;
//   final int order;

//   factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
//         symbol: json["Symbol"],
//         ltp: json["Ltp"].toDouble(),
//         priceChange: json["PriceChange"].toDouble(),
//         percentageChange: json["PercentageChange"].toDouble(),
//         high: json["High"].toDouble(),
//         low: json["Low"].toDouble(),
//         open: json["Open"].toDouble(),
//         qty: json["Qty"],
//         ltv: json["Ltv"],
//         turnOver: json["TurnOver"].toDouble(),
//         dateTime: dateTimeValues.map[json["DateTime"]],
//         order: json["Order"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Symbol": symbol,
//         "Ltp": ltp,
//         "PriceChange": priceChange,
//         "PercentageChange": percentageChange,
//         "High": high,
//         "Low": low,
//         "Open": open,
//         "Qty": qty,
//         "Ltv": ltv,
//         "TurnOver": turnOver,
//         "DateTime": dateTimeValues.reverse[dateTime],
//         "Order": order,
//       };
// }

// enum DateTime { THE_20211214123200 }

// final dateTimeValues =
//     EnumValues({"2021/12/14 12:32:00": DateTime.THE_20211214123200});

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
