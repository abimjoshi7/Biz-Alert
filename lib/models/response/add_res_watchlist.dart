// To parse this JSON data, do
//
//     final addResponseWatchList = addResponseWatchListFromJson(jsonString);

import 'dart:convert';

AddResponseWatchList addResponseWatchListFromJson(Map<String, dynamic> json) =>
    AddResponseWatchList.fromJson(json);

String addResponseWatchListToJson(AddResponseWatchList data) =>
    json.encode(data.toJson());

class AddResponseWatchList {
  AddResponseWatchList({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory AddResponseWatchList.fromJson(Map<String, dynamic> json) =>
      AddResponseWatchList(
        status: json["status"],
        message: json["message"],
        dataCollection: DataCollection.fromJson(json["dataCollection"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "dataCollection": dataCollection.toJson(),
      };
}

class DataCollection {
  DataCollection({
    required this.d,
  });

  final D d;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        d: D.fromJson(json["d"]),
      );

  Map<String, dynamic> toJson() => {
        "d": d.toJson(),
      };
}

class D {
  D({
    required this.msg,
    required this.msgType,
  });

  final String msg;
  final String msgType;

  factory D.fromJson(Map<String, dynamic> json) => D(
        msg: json["msg"],
        msgType: json["msgType"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "msgType": msgType,
      };
}
