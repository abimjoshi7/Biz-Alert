// // To parse this JSON data, do
// //
// //     final dashboardModel = dashboardModelFromJson(jsonString);

// import 'dart:convert';

// DashboardModel dashboardModelFromJson(String str) =>
//     DashboardModel.fromJson(json.decode(str));

// String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

// class DashboardModel {
//   DashboardModel({
//     required this.status,
//     required this.message,
//     required this.dataCollection,
//   });

//   final String status;
//   final String message;
//   final DataCollection dataCollection;

//   factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
//         status: json["status"],
//         message: json["message"],
//         dataCollection: DataCollection.fromJson(json["dataCollection"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "dataCollection": dataCollection.toJson(),
//       };
// }

// class DataCollection {
//   DataCollection({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   final String status;
//   final String message;
//   final Data data;

//   factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
//         status: json["Status"],
//         message: json["Message"],
//         data: Data.fromJson(json["Data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "Status": status,
//         "Message": message,
//         "Data": data.toJson(),
//       };
// }

// class Data {
//   Data({
//     required this.index,
//     required this.services,
//     required this.training,
//     required this.disableServies,
//     this.dashboardItems,
//     required this.forceUpdateApp,
//     required this.appVersionCode,
//     required this.appReleaseCode,
//     required this.showEmailPopUp,
//   });

//   final List<Index> index;
//   final List<Service> services;
//   final List<Training> training;
//   final DisableServies disableServies;
//   final DashboardItems? dashboardItems;
//   final bool forceUpdateApp;
//   final String appVersionCode;
//   final String appReleaseCode;
//   final bool showEmailPopUp;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         index: List<Index>.from(json["Index"].map((x) => Index.fromJson(x))),
//         services: List<Service>.from(
//             json["Services"].map((x) => Service.fromJson(x))),
//         training: List<Training>.from(
//             json["Training"].map((x) => Training.fromJson(x))),
//         disableServies: DisableServies.fromJson(json["DisableServies"]),
//         dashboardItems: DashboardItems.fromJson(json["DashboardItems"]),
//         forceUpdateApp: json["ForceUpdateApp"],
//         appVersionCode: json["AppVersionCode"],
//         appReleaseCode: json["AppReleaseCode"],
//         showEmailPopUp: json["ShowEmailPopUp"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Index": List<dynamic>.from(index.map((x) => x.toJson())),
//         "Services": List<dynamic>.from(services.map((x) => x.toJson())),
//         "Training": List<dynamic>.from(training.map((x) => x.toJson())),
//         "DisableServies": disableServies.toJson(),
//         "DashboardItems": dashboardItems?.toJson(),
//         "ForceUpdateApp": forceUpdateApp,
//         "AppVersionCode": appVersionCode,
//         "AppReleaseCode": appReleaseCode,
//         "ShowEmailPopUp": showEmailPopUp,
//       };
// }

// class DashboardItems {
//   DashboardItems();

//   factory DashboardItems.fromJson(Map<String, dynamic> json) =>
//       DashboardItems();

//   Map<String, dynamic> toJson() => {};
// }

// class DisableServies {
//   DisableServies({
//     required this.smsAutoUpdate,
//     required this.ncellPayment,
//     required this.virtualTrading,
//   });

//   final bool smsAutoUpdate;
//   final bool ncellPayment;
//   final bool virtualTrading;

//   factory DisableServies.fromJson(Map<String, dynamic> json) => DisableServies(
//         smsAutoUpdate: json["SmsAutoUpdate"],
//         ncellPayment: json["ncellPayment"],
//         virtualTrading: json["virtualTrading"],
//       );

//   Map<String, dynamic> toJson() => {
//         "SmsAutoUpdate": smsAutoUpdate,
//         "ncellPayment": ncellPayment,
//         "virtualTrading": virtualTrading,
//       };
// }

// class Index {
//   Index({
//     required this.name,
//     required this.value,
//     required this.percentageChange,
//     required this.isSubindex,
//     required this.datetime,
//     required this.order,
//     required this.indexId,
//   });

//   final String name;
//   final double value;
//   final double percentageChange;
//   final int isSubindex;
//   final Datetime datetime;
//   final int order;
//   final int indexId;

//   factory Index.fromJson(Map<String, dynamic> json) => Index(
//         name: json["Name"],
//         value: json["Value"].toDouble(),
//         percentageChange: json["PercentageChange"].toDouble(),
//         isSubindex: json["IsSubindex"],
//         datetime: datetimeValues.map[json["Datetime"]]!,
//         order: json["Order"],
//         indexId: json["IndexId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Name": name,
//         "Value": value,
//         "PercentageChange": percentageChange,
//         "IsSubindex": isSubindex,
//         "Datetime": datetimeValues.reverse[datetime],
//         "Order": order,
//         "IndexId": indexId,
//       };
// }

// // ignore: constant_identifier_names
// enum Datetime { THE_20211214123300 }

// final datetimeValues =
//     EnumValues({"2021/12/14 12:33:00": Datetime.THE_20211214123300});

// class Service {
//   Service({
//     required this.serviceId,
//     required this.packageName,
//     required this.serviceTypeId,
//   });

//   final String serviceId;
//   final String packageName;
//   final String serviceTypeId;

//   factory Service.fromJson(Map<String, dynamic> json) => Service(
//         serviceId: json["ServiceId"],
//         packageName: json["PackageName"],
//         serviceTypeId: json["ServiceTypeID"],
//       );

//   Map<String, dynamic> toJson() => {
//         "ServiceId": serviceId,
//         "PackageName": packageName,
//         "ServiceTypeID": serviceTypeId,
//       };
// }

// class Training {
//   Training({
//     required this.trainingId,
//     required this.trainingName,
//   });

//   final String trainingId;
//   final String trainingName;

//   factory Training.fromJson(Map<String, dynamic> json) => Training(
//         trainingId: json["TrainingId"],
//         trainingName: json["TrainingName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "TrainingId": trainingId,
//         "TrainingName": trainingName,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap ??= map.map((k, v) => MapEntry(v, k));
//     return reverseMap!;
//   }
// }

// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  DashboardModel({
    required this.status,
    this.message,
    required this.dataCollection,
  });

  final String status;
  final String? message;
  final DataCollection dataCollection;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        status: json["status"],
        message: json["message"] == null ? null : json["message"],
        dataCollection: DataCollection.fromJson(json["dataCollection"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message == null ? null : message,
        "dataCollection": dataCollection.toJson(),
      };
}

class DataCollection {
  DataCollection({
    required this.status,
    this.message,
    required this.data,
  });

  final String status;
  final String? message;
  final Data data;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        status: json["Status"],
        message: json["Message"] == null ? null : json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message == null ? null : message,
        "Data": data.toJson(),
      };
}

class Data {
  Data({
    required this.index,
    required this.services,
    required this.training,
    required this.disableServies,
    this.dashboardItems,
    required this.forceUpdateApp,
    required this.appVersionCode,
    required this.appReleaseCode,
    required this.showEmailPopUp,
  });

  final List<Index> index;
  final List<Service> services;
  final List<Training> training;
  final DisableServies disableServies;
  final DashboardItems? dashboardItems;
  final bool forceUpdateApp;
  final String appVersionCode;
  final String appReleaseCode;
  final bool showEmailPopUp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        index: List<Index>.from(json["Index"].map((x) => Index.fromJson(x))),
        services: List<Service>.from(
            json["Services"].map((x) => Service.fromJson(x))),
        training: List<Training>.from(
            json["Training"].map((x) => Training.fromJson(x))),
        disableServies: DisableServies.fromJson(json["DisableServies"]),
        // dashboardItems: DashboardItems.fromJson(json["DashboardItems"]),
        dashboardItems: json["DashboardItems"] == null
            ? null
            : DashboardItems.fromJson(json["DashboardItems"]),
        forceUpdateApp: json["ForceUpdateApp"],
        appVersionCode: json["AppVersionCode"],
        appReleaseCode: json["AppReleaseCode"],
        showEmailPopUp: json["ShowEmailPopUp"],
      );

  Map<String, dynamic> toJson() => {
        "Index": List<dynamic>.from(index.map((x) => x.toJson())),
        "Services": List<dynamic>.from(services.map((x) => x.toJson())),
        "Training": List<dynamic>.from(training.map((x) => x.toJson())),
        "DisableServies": disableServies.toJson(),
        "DashboardItems":
            dashboardItems == null ? null : dashboardItems!.toJson(),
        "ForceUpdateApp": forceUpdateApp,
        "AppVersionCode": appVersionCode,
        "AppReleaseCode": appReleaseCode,
        "ShowEmailPopUp": showEmailPopUp,
      };
}

class DashboardItems {
  DashboardItems();

  factory DashboardItems.fromJson(Map<String, dynamic> json) =>
      DashboardItems();

  Map<String, dynamic> toJson() => {};
}

class DisableServies {
  DisableServies({
    required this.smsAutoUpdate,
    required this.ncellPayment,
    required this.virtualTrading,
  });

  final bool smsAutoUpdate;
  final bool ncellPayment;
  final bool virtualTrading;

  factory DisableServies.fromJson(Map<String, dynamic> json) => DisableServies(
        smsAutoUpdate: json["SmsAutoUpdate"],
        ncellPayment: json["ncellPayment"],
        virtualTrading: json["virtualTrading"],
      );

  Map<String, dynamic> toJson() => {
        "SmsAutoUpdate": smsAutoUpdate,
        "ncellPayment": ncellPayment,
        "virtualTrading": virtualTrading,
      };
}

class Index {
  Index({
    required this.name,
    required this.value,
    required this.percentageChange,
    required this.isSubindex,
    required this.datetime,
    required this.order,
    required this.indexId,
  });

  final String name;
  final double value;
  final double percentageChange;
  final int isSubindex;
  // final Datetime datetime;
  final String datetime;
  final int order;
  final int indexId;

  factory Index.fromJson(Map<String, dynamic> json) => Index(
        name: json["Name"],
        value: json["Value"].toDouble(),
        percentageChange: json["PercentageChange"].toDouble(),
        isSubindex: json["IsSubindex"],
        // datetime: datetime[json["Datetime"],
        datetime: json["Datetime"],
        order: json["Order"],
        indexId: json["IndexId"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Value": value,
        "PercentageChange": percentageChange,
        "IsSubindex": isSubindex,
        // "Datetime": datetimeValues.reverse[datetime],
        "Datetime": datetime,
        "Order": order,
        "IndexId": indexId,
      };
}

// ignore: constant_identifier_names
// enum Datetime { THE_20211214123300 }

// final datetimeValues =
//     EnumValues({"2021/12/14 12:33:00": Datetime.THE_20211214123300});

class Service {
  Service({
    required this.serviceId,
    required this.packageName,
    required this.serviceTypeId,
  });

  final String serviceId;
  final String packageName;
  final String serviceTypeId;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceId: json["ServiceId"],
        packageName: json["PackageName"],
        serviceTypeId: json["ServiceTypeID"],
      );

  Map<String, dynamic> toJson() => {
        "ServiceId": serviceId,
        "PackageName": packageName,
        "ServiceTypeID": serviceTypeId,
      };
}

class Training {
  Training({
    required this.trainingId,
    required this.trainingName,
  });

  final String trainingId;
  final String trainingName;

  factory Training.fromJson(Map<String, dynamic> json) => Training(
        trainingId: json["TrainingId"],
        trainingName: json["TrainingName"],
      );

  Map<String, dynamic> toJson() => {
        "TrainingId": trainingId,
        "TrainingName": trainingName,
      };
}

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap ??= map.map((k, v) => MapEntry(v, k));
//     return reverseMap!;
//   }
// }
