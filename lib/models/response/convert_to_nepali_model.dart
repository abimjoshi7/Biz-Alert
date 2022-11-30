// To parse this JSON data, do
//
//     final convertToMitiResponseModel = convertToMitiResponseModelFromJson(jsonString);

import 'dart:convert';

ConvertToMitiResponseModel convertToMitiResponseModelFromJson(String str) =>
    ConvertToMitiResponseModel.fromJson(json.decode(str));

String convertToMitiResponseModelToJson(ConvertToMitiResponseModel data) =>
    json.encode(data.toJson());

class ConvertToMitiResponseModel {
  ConvertToMitiResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory ConvertToMitiResponseModel.fromJson(Map<String, dynamic> json) =>
      ConvertToMitiResponseModel(
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
    required this.dateBs,
  });

  final String dateBs;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        dateBs: json["DateBS"],
      );

  Map<String, dynamic> toJson() => {
        "DateBS": dateBs,
      };
}
