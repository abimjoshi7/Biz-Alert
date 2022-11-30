import 'dart:convert';
import 'dart:developer';
import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/models/request/add_stock_req_model.dart';
import 'package:biz_alert/models/request/purchase_transaction_req.dart';
import 'package:biz_alert/models/request/sell_stock_req_model.dart';
import 'package:biz_alert/models/response/add_stock_res_model.dart';
import 'package:biz_alert/models/response/add_stock_share_res_model.dart';
import 'package:biz_alert/models/response/convert_to_nepali_model.dart';
import 'package:biz_alert/models/response/delete_purchase_api_res_model.dart';
import 'package:biz_alert/models/response/delete_purchase_stock_res_model.dart';
import 'package:biz_alert/models/response/delete_sell_stock_res_model.dart';
import 'package:biz_alert/models/response/get_portfolio_res_model.dart';
import 'package:biz_alert/models/response/get_shareholder_res.dart';
import 'package:biz_alert/models/response/portfolio_chart_res_model.dart';
import 'package:biz_alert/models/response/sell_stock_res_model.dart';
import 'package:biz_alert/models/response/show_balance_shares_res_model.dart';
import 'package:dio/dio.dart';

class DioPortfolioChart {
//View Portfolio and Chart
  Future<PortfolioChartResponseModel?> viewPortfolioChart() async {
    String userID = await SecureStorage().readData(key: saveUserID);
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Portfolio/Portfolio?UserId=$userID", //$id,
      );
      log(response.data!);
      // return portfolioChartResponseModelFromJson(response.data!);
      return PortfolioChartResponseModel.fromJson(jsonDecode(response.data!));
    } catch (e) {
      log('Error veiwing portfolio and Chart data: $e');
      return null;
    }
  }

  // Add Stock or Portfolio Calculation Purchase
  Future<AddStockResponseModel?> addStock(
      {required AddStockRequestModel addStockRequestModel}) async {
    try {
      // log(addStockRequestModel.toJson());
      Dio dio = await postClient();
      Response<String> response = await dio.post(
        "/api/Portfolio/PortfolioCalculation_Purchase?userAuth.id=1",
        data: addStockRequestModel.toJson(),
      );
      // log(response.data);
      return AddStockResponseModel.fromJson(jsonDecode(response.data!));
    } catch (e) {
      log('Error adding stock to the portfolio: $e');
      return null;
    }
  }

  // Add Stock Share (AddShare)
  Future<AddStockShareResponseModel?> addNewStockShare({
    required int shareType,
    required String transactionDateAD,
    required String transactionDateBS,
    required String transactionNo,
    required String companyId,
    required String quantity,
    required String rate,
    required int shareHolderId,
    int? brokerId,
    int? portfolioId,
    String? userTransactionID,
  }) async {
    String userID = await SecureStorage().readData(key: saveUserID);
    try {
      // log(companyId);
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Portfolio/AddShare?currentUserInfo=$userID&hdnUserTransactionID=$userTransactionID&ddlShareType=$shareType&txtTransactionDateAD=$transactionDateAD&"
        "txtTransactionDateBS=$transactionDateBS&TransactionNo=$transactionNo&CompanyId=$companyId&Quantity=$quantity&Rate=$rate&"
        "BrokerId=$brokerId&PortfolioId=$portfolioId&ShareholderId=$shareHolderId",
      );
      // log(response.data);
      return addStockShareResponseModelFromJson(response.data!);
    } catch (e) {
      log('Error getting and saving portfolio save data: $e');
      return null;
    }
  }

  // Get ShareHolder
  Future<GetShareHolderResponseModel?> viewShareHolder() async {
    String userID = await SecureStorage().readData(key: saveUserID);
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Portfolio/GetShareHolder?UserId=$userID", //$id,
      );
      // log(response.data);
      // return portfolioChartResponseModelFromJson(response.data!);
      return getShareHolderResponseModelFromJson(response.data!);
    } catch (e) {
      log('Error veiwing shareHolder data: $e');
      return null;
    }
  }

  // Get Portfolio
  Future<GetPortfolioResponseModel?> viewPortfolio() async {
    String userID = await SecureStorage().readData(key: saveUserID);
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Portfolio/GetPortfolio?userId=$userID", //$id,
      );
      // log(response.data);
      return getPortfolioResponseModelFromJson(response.data!);
    } catch (e) {
      log('Error veiwing portfolio data: $e');
      return null;
    }
  }

  // Sell Stock or Portfolio
  Future<SellStockResponseModel?> sellStock(
      {required SellStockRequestModel sellStockRequestModel}) async {
    try {
      // log("sellStockRequestModel");
      // log(sellStockRequestModel.toJson());
      Dio dio = await postClient();
      Response<String> response = await dio.post(
        "/api/Portfolio/PortfolioCalculation_Sell?userAuth.id=1",
        data: sellStockRequestModel.toJson(),
      );
      // log("sellStockResponse");
      // log(response.data);
      return sellStockResponseModelFromJson(response.data!);
    } catch (e) {
      log('Error selling stock to the portfolio: $e');
      return null;
    }
  }

  // Get Balance Shares
  Future<BalanceSharesResponseModel?> getBalanceShares({
    required String companyId,
    required int shareHolderId,
    required int? portfolioId,
  }) async {
    String userID = await SecureStorage().readData(key: saveUserID);
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Portfolio/ShowBalanceshares?UserId=$userID&CompanyId=$companyId&PortfolioId=$portfolioId&ShareHolderId=$shareHolderId",
      );
      // log(response.data);
      return BalanceSharesResponseModel.fromJson(jsonDecode(response.data!));
    } catch (e) {
      log('Error getting balance shares data: $e');
      return null;
    }
  }

  // Sell Stock Share (SellShare)
  Future<AddStockShareResponseModel?> saveSellStockShare(
      {required String transactionDateAD,
      required String transactionDateBS,
      required PurchaseTransactionRequest model}) async {
    String json = jsonEncode(model.toJson());
    String userID = await SecureStorage().readData(key: saveUserID);
    try {
      // log("PurchaseTransactionRequest");
      // log(json);
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Portfolio/SellShare?currentUserInfo=$userID&txtTransactionDateAD=$transactionDateAD&txtTransactionDateBS=$transactionDateBS&PurchaseTransaction=[$json]",
      );
      // log("saveSellStockResponse");
      // log(response.data);
      return addStockShareResponseModelFromJson(response.data!);
    } catch (e) {
      log('Error getting and sell share data: $e');
      return null;
    }
  }

  // For Delete
  // Purchase Share List
  Future<DeletePurchaseStockResponseModel?> deletePurchaseStockList({
    String? sectorValue,
    required String symbolNumber,
    String? shareType,
    required String portfolioID,
    required String shareHolderID,
    required int pageNumber,
  }) async {
    String userID = await SecureStorage().readData(key: saveUserID);
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Shares/PurhaseSharesList?CustomerID=$userID&SectorValue=0&Symbol=$symbolNumber&ShareType=0&PortFolio=$portfolioID&ShareHolder=$shareHolderID&PageNumber=$pageNumber",
      );
      // log(response.data);
      return deletePurchaseStockResponseModelFromJson(response.data!);
    } catch (e) {
      log('Error getting the purchase list: $e');
      return null;
    }
  }

  // Purchase Delete API
  Future<DeletePurchaseApiResponseModel?> deletePurchaseStockApi({
    required String userTransactionID,
  }) async {
    String userID = await SecureStorage().readData(key: saveUserID);
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Shares/PurchaseShareDelete?userID=$userID&userTransactionID=$userTransactionID",
      );
      // log(response.data);
      return deletePurchaseApiResponseModelFromJson(response.data!);
    } catch (e) {
      log('Error deleting the list: $e');
      return null;
    }
  }

  // Sold Share List
  Future<DeleteSellStockResponseModel?> deleteSellStockList({
    required String symbolNumber,
    String? sectorValue,
    required int pageNumber,
  }) async {
    String userID = await SecureStorage().readData(key: saveUserID);
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Shares/SoldSharesList?CustomerId=$userID&SectorValue=0&Symbol=$symbolNumber&PageNumber=$pageNumber",
      );
      // log(response.data);
      return deleteSellStockResponseModelFromJson(response.data!);
    } catch (e) {
      log('Error getting the sell list: $e');
      return null;
    }
  }

  // Sold Delete API
  Future<DeletePurchaseApiResponseModel?> deleteSellStockApi({
    required String userTransactionID,
  }) async {
    String userID = await SecureStorage().readData(key: saveUserID);
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Shares/SoldSharesDelete?CustomerId=$userID&userTransactionID=$userTransactionID",
      );
      // log(response.data);
      return deletePurchaseApiResponseModelFromJson(response.data!);
    } catch (e) {
      log('Error deleting the sold share: $e');
      return null;
    }
  }

  // Convert to Miti
  Future<ConvertToMitiResponseModel?> convertToMiti({
    required String date,
  }) async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Portfolio/ConvertDateToMiti?date=$date",
      );
      // log(response.data);
      return convertToMitiResponseModelFromJson(response.data!);
    } catch (e) {
      log('Error converting to miti: $e');
      return null;
    }
  }
}
