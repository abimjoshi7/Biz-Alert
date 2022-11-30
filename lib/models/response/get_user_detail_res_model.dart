// To parse this JSON data, do
//
//     final userDetailsResponseModel = userDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

UserDetailsResponseModel userDetailsResponseModelFromJson(String str) =>
    UserDetailsResponseModel.fromJson(json.decode(str));

String userDetailsResponseModelToJson(UserDetailsResponseModel data) =>
    json.encode(data.toJson());

class UserDetailsResponseModel {
  UserDetailsResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory UserDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsResponseModel(
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
    required this.msg,
    required this.data,
  });

  final String msg;
  final List<Datum> data;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.mobileNumber,
    this.phone,
    this.address,
    this.city,
    this.country = 2,
  });

  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? email;
  final String? mobileNumber;
  final String? phone;
  final String? address;
  final String? city;
  final int? country;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "email": email,
        "mobileNumber": mobileNumber,
        "phone": phone,
        "address": address,
        "city": city,
        "country": country,
      };
}
