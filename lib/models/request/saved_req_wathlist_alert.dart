// To parse this JSON data, do
//
//     final getSavedWatchlistAlertRequest = getSavedWatchlistAlertRequestFromJson(jsonString);

import 'dart:convert';

GetSavedWatchlistAlertRequest getSavedWatchlistAlertRequestFromJson(
        String str) =>
    GetSavedWatchlistAlertRequest.fromJson(json.decode(str));

String getSavedWatchlistAlertRequestToJson(
        GetSavedWatchlistAlertRequest data) =>
    json.encode(data.toJson());

class GetSavedWatchlistAlertRequest {
  GetSavedWatchlistAlertRequest({
    required this.userId,
    required this.companyId,
  });

  final String userId;
  final int companyId;

  factory GetSavedWatchlistAlertRequest.fromJson(Map<String, dynamic> json) =>
      GetSavedWatchlistAlertRequest(
        userId: json["userId"],
        companyId: json["companyId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "companyId": companyId,
      };
}
