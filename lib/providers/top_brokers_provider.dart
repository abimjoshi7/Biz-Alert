import 'package:biz_alert/features/dashboard/market_overview/services/dio_market.dart';
import 'package:biz_alert/models/response/top_brokers_res_model.dart';
import 'package:flutter/material.dart';

class TopBrokersProvider extends ChangeNotifier {
  TopBrokersResModel? topBrokersResModel;
  bool loading = false;

  Future<TopBrokersResModel>? getTopBrokersData() async {
    loading = true;
    topBrokersResModel = await DioMarket().getTopBrokers();

    loading = false;

    notifyListeners();
    return topBrokersResModel!;
  }
}
