// To parse this JSON data, do
//
//     final postWatchList = postWatchListFromJson(jsonString);

import 'dart:convert';

AddRequestWatchList postWatchListFromJson(String str) =>
    AddRequestWatchList.fromJson(json.decode(str));

String postWatchListToJson(AddRequestWatchList data) =>
    json.encode(data.toJson());

class AddRequestWatchList {
  AddRequestWatchList({
    required this.userId,
    required this.companyId,
  });

  final String userId;
  final int companyId;

  factory AddRequestWatchList.fromJson(Map<String, dynamic> json) =>
      AddRequestWatchList(
        userId: json["userId"],
        companyId: json["companyId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "companyId": companyId,
      };
}
