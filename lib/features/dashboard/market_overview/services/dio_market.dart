import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/models/response/gainer_losers_details.dart';
import 'package:biz_alert/models/response/top_brokers_res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioMarket {
  // Gainers Details
  Future<AllGainersLosersDetailsResModel?> viewGainersDetail() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
          "/api/IndexWebService/GetAllGainersLosersDetails?GainerOrLoser=gainers");
      return allGainersLosersDetailsResModelFromJson(response.data!);
    } catch (e) {
      if (kDebugMode) {
        print("Error viewing the Gainer Details");
      }
      return null;
    }
  }

  // // Losers Details
  Future<AllGainersLosersDetailsResModel?> viewLosersDetail() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
          "/api/IndexWebService/GetAllGainersLosersDetails?GainerOrLoser=losers");
      return allGainersLosersDetailsResModelFromJson(response.data!);
    } catch (e) {
      if (kDebugMode) {
        print("Error viewing the Losers Details");
      }
      return null;
    }
  }

  Future<TopBrokersResModel?> getTopBrokers() async {
    try {
      Dio dio = await getClient();
      Response<String> response =
          await dio.get("/api/IndexWebService/GetAllTopBrokers");
      return topBrokersResModelFromMap(response.data!);
    } catch (e) {
      if (kDebugMode) {
        print("Error viewing the Losers Details");
      }
      return null;
    }
  }
}
