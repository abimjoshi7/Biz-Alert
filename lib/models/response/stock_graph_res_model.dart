// To parse this JSON data, do
//
//     final stockGraphResModel = stockGraphResModelFromMap(jsonString);

import 'dart:convert';

StockGraphResModel stockGraphResModelFromMap(String str) =>
    StockGraphResModel.fromMap(json.decode(str));

String stockGraphResModelToMap(StockGraphResModel data) =>
    json.encode(data.toMap());

class StockGraphResModel {
  StockGraphResModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  StockGraphResModel copyWith({
    String? status,
    String? message,
    DataCollection? dataCollection,
  }) =>
      StockGraphResModel(
        status: status ?? this.status,
        message: message ?? this.message,
        dataCollection: dataCollection ?? this.dataCollection,
      );

  factory StockGraphResModel.fromMap(Map<String, dynamic> json) =>
      StockGraphResModel(
        status: json["status"],
        message: json["message"],
        dataCollection: DataCollection.fromMap(json["dataCollection"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "dataCollection": dataCollection.toMap(),
      };
}

class DataCollection {
  DataCollection({
    required this.msgtype,
    required this.msg,
    required this.agm,
  });

  final String msgtype;
  final String msg;
  final List<Agm> agm;

  DataCollection copyWith({
    String? msgtype,
    String? msg,
    List<Agm>? agm,
  }) =>
      DataCollection(
        msgtype: msgtype ?? this.msgtype,
        msg: msg ?? this.msg,
        agm: agm ?? this.agm,
      );

  factory DataCollection.fromMap(Map<String, dynamic> json) => DataCollection(
        msgtype: json["msgtype"],
        msg: json["msg"],
        agm: List<Agm>.from(json["AGM"].map((x) => Agm.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "msgtype": msgtype,
        "msg": msg,
        "AGM": List<dynamic>.from(agm.map((x) => x.toMap())),
      };
}

class Agm {
  Agm({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.changeInPrice,
    required this.dateTime,
    required this.unixDateTime,
  });

  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;
  final double changeInPrice;
  final String dateTime;
  final int unixDateTime;

  Agm copyWith({
    double? open,
    double? high,
    double? low,
    double? close,
    int? volume,
    double? changeInPrice,
    String? dateTime,
    int? unixDateTime,
  }) =>
      Agm(
        open: open ?? this.open,
        high: high ?? this.high,
        low: low ?? this.low,
        close: close ?? this.close,
        volume: volume ?? this.volume,
        changeInPrice: changeInPrice ?? this.changeInPrice,
        dateTime: dateTime ?? this.dateTime,
        unixDateTime: unixDateTime ?? this.unixDateTime,
      );

  factory Agm.fromMap(Map<String, dynamic> json) => Agm(
        open: json["Open"].toDouble(),
        high: json["High"].toDouble(),
        low: json["Low"].toDouble(),
        close: json["Close"].toDouble(),
        volume: json["Volume"],
        changeInPrice: json["ChangeInPrice"].toDouble(),
        dateTime: json["DateTime"],
        unixDateTime: json["UnixDateTime"],
      );

  Map<String, dynamic> toMap() => {
        "Open": open,
        "High": high,
        "Low": low,
        "Close": close,
        "Volume": volume,
        "ChangeInPrice": changeInPrice,
        "DateTime": dateTime,
        "UnixDateTime": unixDateTime,
      };
}
