import 'package:biz_alert/features/dashboard/services/dio_dashboard.dart';
import 'package:biz_alert/models/response/top_turnover_res_model.dart';
import 'package:flutter/material.dart';

class TopTurnoverProvider extends ChangeNotifier {
  TopTurnoverModel? topTurnover;
  bool loading = false;

  Future<TopTurnoverModel>? getTopTurnoverData() async {
    loading = true;
    topTurnover = await DioDashboard().viewTopTurnover();

    loading = false;

    notifyListeners();
    return topTurnover!;
  }
}
