// To parse this JSON data, do
//
//     final getResponseWatchList = getResponseWatchListFromJson(jsonString);

import 'dart:convert';

GetRequestWatchList getRequestWatchListFromJson(String str) =>
    GetRequestWatchList.fromJson(json.decode(str));

String getRequestWatchListToJson(GetRequestWatchList data) =>
    json.encode(data.toJson());

class GetRequestWatchList {
  GetRequestWatchList({
    required this.userId,
    required this.companyId,
  });

  final String userId;
  final int companyId;

  factory GetRequestWatchList.fromJson(Map<String, dynamic> json) =>
      GetRequestWatchList(
        userId: json["userId"],
        companyId: json["companyId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "companyId": companyId,
      };
}
