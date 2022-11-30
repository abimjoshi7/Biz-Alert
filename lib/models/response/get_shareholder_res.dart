// To parse this JSON data, do
//
//     final getShareHolderResponseModel = getShareHolderResponseModelFromJson(jsonString);

import 'dart:convert';

GetShareHolderResponseModel getShareHolderResponseModelFromJson(String str) =>
    GetShareHolderResponseModel.fromJson(json.decode(str));

String getShareHolderResponseModelToJson(GetShareHolderResponseModel data) =>
    json.encode(data.toJson());

class GetShareHolderResponseModel {
  GetShareHolderResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  factory GetShareHolderResponseModel.fromJson(Map<String, dynamic> json) =>
      GetShareHolderResponseModel(
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
    required this.nameAndCode,
    required this.shareholderId,
  });

  final String nameAndCode;
  final int shareholderId;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        nameAndCode: json["NameAndCode"],
        shareholderId: json["shareholderID"],
      );

  Map<String, dynamic> toJson() => {
        "NameAndCode": nameAndCode,
        "shareholderID": shareholderId,
      };
}
