// To parse this JSON data, do
//
//     final deleteRequestWatchlist = deleteRequestWatchlistFromJson(jsonString);

import 'dart:convert';

DeleteRequestWatchlist deleteRequestWatchlistFromJson(String str) =>
    DeleteRequestWatchlist.fromJson(json.decode(str));

String deleteRequestWatchlistToJson(DeleteRequestWatchlist data) =>
    json.encode(data.toJson());

class DeleteRequestWatchlist {
  DeleteRequestWatchlist({
    required this.userId,
    required this.companyId,
  });

  final String userId;
  final int companyId;

  factory DeleteRequestWatchlist.fromJson(Map<String, dynamic> json) =>
      DeleteRequestWatchlist(
        userId: json["userId"],
        companyId: json["companyId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "companyId": companyId,
      };
}
