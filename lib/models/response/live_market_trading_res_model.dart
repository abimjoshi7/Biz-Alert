// To parse this JSON data, do
//
//     final liveMarketTradingModel = liveMarketTradingModelFromJson(jsonString);

import 'dart:convert';

LiveMarketTradingModel liveMarketTradingModelFromJson(String str) =>
    LiveMarketTradingModel.fromJson(json.decode(str));

String liveMarketTradingModelToJson(LiveMarketTradingModel data) =>
    json.encode(data.toJson());

class LiveMarketTradingModel {
  LiveMarketTradingModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  factory LiveMarketTradingModel.fromJson(Map<String, dynamic> json) =>
      LiveMarketTradingModel(
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
    required this.id,
    required this.symbol,
    required this.ltp,
    required this.ltv,
    required this.percentageChangePrice,
    required this.high,
    required this.low,
    required this.open,
    required this.qty,
    required this.date,
    required this.previousClose,
  });

  final String id;
  final String symbol;
  final String ltp;
  final String ltv;
  final String percentageChangePrice;
  final String high;
  final String low;
  final String open;
  final String qty;
  final String date;
  final String previousClose;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        id: json["ID"],
        symbol: json["Symbol"],
        ltp: json["LTP"],
        ltv: json["LTV"],
        percentageChangePrice: json["PercentageChangePrice"],
        high: json["High"],
        low: json["Low"],
        open: json["Open"],
        qty: json["Qty"],
        date: json["Date"],
        previousClose: json["PreviousClose"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Symbol": symbol,
        "LTP": ltp,
        "LTV": ltv,
        "PercentageChangePrice": percentageChangePrice,
        "High": high,
        "Low": low,
        "Open": open,
        "Qty": qty,
        "Date": date,
        "PreviousClose": previousClose,
      };
}




























// // To parse this JSON data, do
// //
// //     final liveMarketTradingModel = liveMarketTradingModelFromJson(jsonString);

// import 'dart:convert';

// LiveMarketTradingModel liveMarketTradingModelFromJson(String str) =>
//     LiveMarketTradingModel.fromJson(json.decode(str));

// String liveMarketTradingModelToJson(LiveMarketTradingModel data) =>
//     json.encode(data.toJson());

// class LiveMarketTradingModel {
//   LiveMarketTradingModel({
//     required this.status,
//     required this.message,
//     required this.dataCollection,
//   });

//   final String status;
//   final String message;
//   final List<DataCollection> dataCollection;

//   factory LiveMarketTradingModel.fromJson(Map<String, dynamic> json) =>
//       LiveMarketTradingModel(
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
//     required this.id,
//     required this.symbol,
//     required this.ltp,
//     required this.ltv,
//     required this.percentageChangePrice,
//     required this.high,
//     required this.low,
//     required this.open,
//     required this.qty,
//     required this.date,
//     required this.previousClose,
//   });

//   final String id;
//   final String symbol;
//   final String ltp;
//   final String ltv;
//   final String percentageChangePrice;
//   final String high;
//   final String low;
//   final String open;
//   final String qty;
//   final Date? date;
//   final String previousClose;

//   factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
//         id: json["ID"],
//         symbol: json["Symbol"],
//         ltp: json["LTP"],
//         ltv: json["LTV"],
//         percentageChangePrice: json["PercentageChangePrice"],
//         high: json["High"],
//         low: json["Low"],
//         open: json["Open"],
//         qty: json["Qty"],
//         date: dateValues.map[json["Date"]],
//         previousClose: json["PreviousClose"],
//       );

//   Map<String, dynamic> toJson() => {
//         "ID": id,
//         "Symbol": symbol,
//         "LTP": ltp,
//         "LTV": ltv,
//         "PercentageChangePrice": percentageChangePrice,
//         "High": high,
//         "Low": low,
//         "Open": open,
//         "Qty": qty,
//         "Date": dateValues.reverse[date],
//         "PreviousClose": previousClose,
//       };
// }

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
