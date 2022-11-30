// To parse this JSON data, do
//
//     final watchlistAlertSettingsRequest = watchlistAlertSettingsRequestFromJson(jsonString);

import 'dart:convert';

WatchlistAlertSettingsRequest watchlistAlertSettingsRequestFromJson(
        String str) =>
    WatchlistAlertSettingsRequest.fromJson(json.decode(str));

String watchlistAlertSettingsRequestToJson(
        WatchlistAlertSettingsRequest data) =>
    json.encode(data.toJson());

class WatchlistAlertSettingsRequest {
  WatchlistAlertSettingsRequest({
    required this.userId,
    required this.alertWatchlistSettings,
  });

  final String userId;
  final List<AlertWatchlistSetting> alertWatchlistSettings;

  factory WatchlistAlertSettingsRequest.fromJson(Map<String, dynamic> json) =>
      WatchlistAlertSettingsRequest(
        userId: json["userId"],
        alertWatchlistSettings: List<AlertWatchlistSetting>.from(
            json["alertWatchlistSettings"]
                .map((x) => AlertWatchlistSetting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "alertWatchlistSettings":
            List<dynamic>.from(alertWatchlistSettings.map((x) => x.toJson())),
      };
}

class AlertWatchlistSetting {
  AlertWatchlistSetting({
    required this.companyId,
    required this.isAlertEnabled,
    required this.sendEmailOnIncrease,
    required this.sendEmailOnDecrease,
    required this.sendSmsOnIncrease,
    required this.sendSmsOnDecrease,
    required this.increasePrice,
    required this.decreasePrice,
  });

  final int companyId;
  final int isAlertEnabled;
  final int sendEmailOnIncrease;
  final int sendEmailOnDecrease;
  final int sendSmsOnIncrease;
  final int sendSmsOnDecrease;
  final int increasePrice;
  final int decreasePrice;

  factory AlertWatchlistSetting.fromJson(Map<String, dynamic> json) =>
      AlertWatchlistSetting(
        companyId: json["CompanyID"],
        isAlertEnabled: json["IsAlertEnabled"],
        sendEmailOnIncrease: json["SendEmailOnIncrease"],
        sendEmailOnDecrease: json["SendEmailOnDecrease"],
        sendSmsOnIncrease: json["SendSmsOnIncrease"],
        sendSmsOnDecrease: json["SendSmsOnDecrease"],
        increasePrice: json["increasePrice"],
        decreasePrice: json["decreasePrice"],
      );

  Map<String, dynamic> toJson() => {
        "CompanyID": companyId,
        "IsAlertEnabled": isAlertEnabled,
        "SendEmailOnIncrease": sendEmailOnIncrease,
        "SendEmailOnDecrease": sendEmailOnDecrease,
        "SendSmsOnIncrease": sendSmsOnIncrease,
        "SendSmsOnDecrease": sendSmsOnDecrease,
        "increasePrice": increasePrice,
        "decreasePrice": decreasePrice,
      };
}
