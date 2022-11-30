import 'dart:developer';

import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/models/response/company_detail_price_history_res_model.dart';
import 'package:biz_alert/models/response/company_detail_res.dart';
import 'package:dio/dio.dart';

import '../../../../models/response/company_detail_floorsheet_res_model.dart';
import '../../../../models/response/stock_graph_res_model.dart';

class DioCompanyDetail {
  Future<CompanyDetailResModel?> viewCompanyDetail({
    required String companySym,
  }) async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
          "/api/CompanyDetail/GetCompanyDetailBySymbol?symbol=$companySym");
      return companyDetailResModelFromJson(response.data!);
    } catch (e) {
      log("Error getting company detail $e");
      return null;
    }
  }

  Future<CompanyDetailFloorsheetResModel> viewFloorsheet({
    required String companySym,
  }) async {
    try {
      Dio dio = await getClient();
      Response<String> response =
          await dio.get("/api/CompanyDetail/GetFloorsheet?symbol=$companySym");
      return companyDetailFloorsheetResModelFromMap(response.data!);
    } catch (e) {
      log("Error getting company detail floorsheet$e");
      rethrow;
    }
  }

  Future<CompanyDetailPriceHistoryResModel> viewPriceHistory(
      {required String companySym, String? date}) async {
    try {
      Dio dio = await getClient();
      Response<String> response =
          await dio.get("/api/CompanyDetail/GetPriceHistory", queryParameters: {
        "symbol": companySym,
        "marketDate": date,
      });
      return companyDetailPriceHistoryResModelFromMap(response.data!);
    } catch (e) {
      log("Error getting company detail price history$e");
      rethrow;
    }
  }

  Future<StockGraphResModel> viewStockGraph(
      {required String companySym, required int period}) async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
          "/api/CompanyDetail/GetStockGraph?stockSymbol=$companySym&period=$period");
      return stockGraphResModelFromMap(response.data!);
    } catch (e) {
      log("Error getting company detail graph$e");
      rethrow;
    }
  }
}
