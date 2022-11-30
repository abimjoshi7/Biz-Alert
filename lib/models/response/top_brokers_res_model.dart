// To parse this JSON data, do
//
//     final topBrokersResModel = topBrokersResModelFromMap(jsonString);

import 'dart:convert';

TopBrokersResModel topBrokersResModelFromMap(String str) =>
    TopBrokersResModel.fromMap(json.decode(str));

String topBrokersResModelToMap(TopBrokersResModel data) =>
    json.encode(data.toMap());

class TopBrokersResModel {
  TopBrokersResModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  TopBrokersResModel copyWith({
    String? status,
    String? message,
    List<DataCollection>? dataCollection,
  }) =>
      TopBrokersResModel(
        status: status ?? this.status,
        message: message ?? this.message,
        dataCollection: dataCollection ?? this.dataCollection,
      );

  factory TopBrokersResModel.fromMap(Map<String, dynamic> json) =>
      TopBrokersResModel(
        status: json["status"],
        message: json["message"],
        dataCollection: List<DataCollection>.from(
            json["dataCollection"].map((x) => DataCollection.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "dataCollection":
            List<dynamic>.from(dataCollection.map((x) => x.toMap())),
      };
}

class DataCollection {
  DataCollection({
    required this.brokerCode,
    required this.brokerName,
    required this.purchasedAmount,
    required this.soldAmount,
    required this.matchingAmount,
    required this.totalAmount,
    required this.date,
  });

  final String brokerCode;
  final String brokerName;
  final double purchasedAmount;
  final double soldAmount;
  final double matchingAmount;
  final double totalAmount;
  final String date;

  DataCollection copyWith({
    String? brokerCode,
    String? brokerName,
    double? purchasedAmount,
    double? soldAmount,
    double? matchingAmount,
    double? totalAmount,
    String? date,
  }) =>
      DataCollection(
        brokerCode: brokerCode ?? this.brokerCode,
        brokerName: brokerName ?? this.brokerName,
        purchasedAmount: purchasedAmount ?? this.purchasedAmount,
        soldAmount: soldAmount ?? this.soldAmount,
        matchingAmount: matchingAmount ?? this.matchingAmount,
        totalAmount: totalAmount ?? this.totalAmount,
        date: date ?? this.date,
      );

  factory DataCollection.fromMap(Map<String, dynamic> json) => DataCollection(
        brokerCode: json["BrokerCode"],
        brokerName: json["BrokerName"],
        purchasedAmount: json["PurchasedAmount"].toDouble(),
        soldAmount: json["SoldAmount"].toDouble(),
        matchingAmount: json["MatchingAmount"].toDouble(),
        totalAmount: json["TotalAmount"].toDouble(),
        date: json["date"],
      );

  Map<String, dynamic> toMap() => {
        "BrokerCode": brokerCode,
        "BrokerName": brokerName,
        "PurchasedAmount": purchasedAmount,
        "SoldAmount": soldAmount,
        "MatchingAmount": matchingAmount,
        "TotalAmount": totalAmount,
        "date": date,
      };
}

// enum Date { THE_04242022030000 }

// final dateValues = EnumValues({
//     "04/24/2022 03:00:00": Date.THE_04242022030000
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
