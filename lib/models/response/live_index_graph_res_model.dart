// To parse this JSON data, do
//
//     final liveIndexGraphModel = liveIndexGraphModelFromJson(jsonString);

import 'dart:convert';

LiveIndexGraphModel liveIndexGraphModelFromJson(String str) =>
    LiveIndexGraphModel.fromJson(json.decode(str));

String liveIndexGraphModelToJson(LiveIndexGraphModel data) =>
    json.encode(data.toJson());

class LiveIndexGraphModel {
  LiveIndexGraphModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory LiveIndexGraphModel.fromJson(Map<String, dynamic> json) =>
      LiveIndexGraphModel(
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
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final Data data;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.indexGraph,
    required this.indexSummary,
    required this.marketStatus,
  });

  final List<IndexGraph> indexGraph;
  final IndexSummary indexSummary;
  final MarketStatus marketStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        indexGraph: List<IndexGraph>.from(
            json["indexGraph"].map((x) => IndexGraph.fromJson(x))),
        indexSummary: IndexSummary.fromJson(json["indexSummary"]),
        marketStatus: MarketStatus.fromJson(json["marketStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "indexGraph": List<dynamic>.from(indexGraph.map((x) => x.toJson())),
        "indexSummary": indexSummary.toJson(),
        "marketStatus": marketStatus.toJson(),
      };
}

class IndexGraph {
  IndexGraph({
    required this.date,
    required this.time,
    required this.value,
    required this.high,
    required this.low,
    required this.close,
  });

  final DateTime date;
  final String time;
  final double value;
  final double high;
  final double low;
  final double close;

  factory IndexGraph.fromJson(Map<String, dynamic> json) => IndexGraph(
        date: DateTime.parse(json["date"]),
        time: json["time"],
        value: json["value"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        close: json["close"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "value": value,
        "high": high,
        "low": low,
        "close": close,
      };
}

class IndexSummary {
  IndexSummary({
    required this.indexName,
    required this.indexPoint,
    required this.absoluteChange,
    required this.percentageChange,
    required this.turnOver,
    required this.advances,
    required this.declines,
    required this.noChange,
  });

  final String indexName;
  final String indexPoint;
  final String absoluteChange;
  final String percentageChange;
  final String turnOver;
  final String advances;
  final String declines;
  final String noChange;

  factory IndexSummary.fromJson(Map<String, dynamic> json) => IndexSummary(
        indexName: json["indexName"],
        indexPoint: json["indexPoint"],
        absoluteChange: json["absoluteChange"],
        percentageChange: json["percentageChange"],
        turnOver: json["turnOver"],
        advances: json["advances"],
        declines: json["declines"],
        noChange: json["noChange"],
      );

  Map<String, dynamic> toJson() => {
        "indexName": indexName,
        "indexPoint": indexPoint,
        "absoluteChange": absoluteChange,
        "percentageChange": percentageChange,
        "turnOver": turnOver,
        "advances": advances,
        "declines": declines,
        "noChange": noChange,
      };
}

class MarketStatus {
  MarketStatus({
    required this.status,
  });

  final String status;

  factory MarketStatus.fromJson(Map<String, dynamic> json) => MarketStatus(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
