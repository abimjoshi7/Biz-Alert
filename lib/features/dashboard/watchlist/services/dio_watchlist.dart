import 'dart:developer';

import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/models/request/add_req_watchlist.dart';
import 'package:biz_alert/models/request/del_req_watchlist.dart';
import 'package:biz_alert/models/request/get_req_watchlist.dart';
import 'package:biz_alert/models/request/saved_req_wathlist_alert.dart';
import 'package:biz_alert/models/request/watchlist_settings_req_model.dart';
import 'package:biz_alert/models/response/add_res_watchlist.dart';
import 'package:biz_alert/models/response/del_res_watchlist.dart';
import 'package:biz_alert/models/response/get_res_watchlist.dart';
import 'package:biz_alert/models/response/saved_res%20_watchlist_alert.dart';
import 'package:biz_alert/models/response/watchlist_settings_res_model.dart';
import 'package:dio/dio.dart';

class DioWatchList {
  Future<GetResponseWatchList> getInitialShareInfo() async {
    String userID = await SecureStorage().readData(key: saveUserID);
    log("User ID:" + userID);
    final response = await getRequestWatchList(
      GetRequestWatchList(userId: userID, companyId: 0),
    );
    log("Watchlist Response: " + response.toString());
    return response;
  }

  Future<GetResponseWatchList> getRequestWatchList(
      GetRequestWatchList getRequestWatchList) async {
    Dio dio = await postClient();
    final response = await dio.post(
      "/api/Watchlist/GetWatchlist?userAuth.id=1",
      data: getRequestWatchList.toJson(),
    );
    return getResponseWatchListFromJson(response.data);
  }

  Future<AddResponseWatchList> addRequestWatchList(
      AddRequestWatchList postRequestWatchList) async {
    Dio dio = await postClient();
    final response = await dio.post(
      "/api/Watchlist/AddWatchlist?userAuth.id=1",
      data: postRequestWatchList.toJson(),
    );
    return addResponseWatchListFromJson(response.data);
  }

  Future<DeleteResponseWatchlist> deleteWatchlist(
      DeleteRequestWatchlist deleteRequestWatchlist) async {
    Dio dio = await postClient();
    final response = await dio.post(
      "/api/Watchlist/DeleteWatchlist?userAuth.id=1",
      data: deleteRequestWatchlistToJson(deleteRequestWatchlist),
    );
    return deleteResponseWatchlistFromJson(response.data);
  }

  Future<GetSavedWatchlistAlertResponse> getWatchlistAlert(
      GetSavedWatchlistAlertRequest getSavedWatchlistAlertRequest) async {
    Dio dio = await postClient();
    final response = await dio.post(
      "/api/Watchlist/WatchlistAlertGet?userAuth.id=1",
      data: getSavedWatchlistAlertRequestToJson(getSavedWatchlistAlertRequest),
    );
    return getSavedWatchlistAlertResponseFromJson(response.data);
  }

  Future<GetSavedWatchlistAlertResponse> getInitialWatchlistAlertInfo() async {
    String userID = await SecureStorage().readData(key: saveUserID);

    final response = await getWatchlistAlert(
      GetSavedWatchlistAlertRequest(userId: userID, companyId: 0),
    );
    return response;
  }

  Future<WatchlistAlertSettingsResponse> configWatchlistAlert(
      WatchlistAlertSettingsRequest watchlistAlertSettingsRequest) async {
    Dio dio = await postClient();
    final response = await dio.post(
        "/api/Watchlist/WatchlistAlertSettings?userAuth.id=1",
        data:
            watchlistAlertSettingsRequestToJson(watchlistAlertSettingsRequest));
    return watchlistAlertSettingsResponseFromJson(response.data);
  }

  // Future<void> postResponseWatchList(
  //     PostRequestWatchList postRequestWatchList) async {
  //   final res = Post;
  // }
}
