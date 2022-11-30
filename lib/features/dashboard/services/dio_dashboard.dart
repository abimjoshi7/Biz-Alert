import 'dart:developer';

import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/models/response/dashboard_res_model.dart';
import 'package:biz_alert/models/response/get_indices_res_model.dart';
import 'package:biz_alert/models/response/live_index_graph_res_model.dart';
import 'package:biz_alert/models/response/market_summary_res_model.dart';
import 'package:biz_alert/models/response/top_gainers_res_model.dart';
import 'package:biz_alert/models/response/top_losers_res_model.dart';
import 'package:biz_alert/models/response/top_sector_res_model.dart';
import 'package:biz_alert/models/response/top_turnover_res_model.dart';
import 'package:dio/dio.dart';

class DioDashboard {
//View Dashboard Data
  Future<DashboardModel?> viewDashboard() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Dashboard/GetDashboard?userAuth.id=1", //$id,
      );
      return dashboardModelFromJson(response.data!);
    } catch (e) {
      log(e.toString());
      // return null;
    }
  }

  // Get Indices Data
  Future<GetIndicesModel?> viewIndices() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/IndexWebService/GetIndices?userAuth.id=1",
      );
      return getIndicesModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }

  // Market Summary Data
  Future<MarketSummaryModel?> viewMarketSummary() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/IndexWebService/GetSummary?userAuth.id=1",
      );
      return marketSummaryModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }

  // Live Index Graph
  Future<LiveIndexGraphModel?> viewLiveIndexGraph(
      {required int indexID}) async {
    // print("object");
    // print(indexID.toString());
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/IndexWebService/GetLiveIndexGraph?indexId=$indexID",
      );
      // print(response.data);
      return liveIndexGraphModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }

  // Top Gainers
  Future<TopGainersModel?> viewTopGainers() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/IndexWebService/GetAllGainerLoser?GainerOrLoser=gainers",
      );
      return topGainersModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }

  // Top Losers
  Future<TopLosersModel?> viewTopLosers() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/IndexWebService/GetAllGainerLoser?GainerOrLoser=losers",
      );
      return topLosersModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }

  // Top TurnOver
  Future<TopTurnoverModel?> viewTopTurnover() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/IndexWebService/GetAllTurnOvers?turnoverType=by%20symbol",
      );
      return topTurnoverModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }

  // Top Sector
  Future<TopSectorModel?> viewTopSector() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/IndexWebService/GetAllTurnOvers?turnoverType=by%20sector",
      );
      return topSectorModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }
}
