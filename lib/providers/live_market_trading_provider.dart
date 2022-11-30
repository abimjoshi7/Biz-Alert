import 'package:biz_alert/features/dashboard/live_market/services/dio_live_market.dart';
import 'package:biz_alert/models/response/live_market_trading_res_model.dart';
import 'package:flutter/material.dart';

class LiveMarketTradingProvider extends ChangeNotifier {
  LiveMarketTradingModel? liveMarket;
  bool loading = false;

  Future<LiveMarketTradingModel>? getLiveMarketTradingData() async {
    loading = true;
    liveMarket = await DioLiveMarketTrading().viewLiveTrading();

    loading = false;

    notifyListeners();
    return liveMarket!;
  }
}
