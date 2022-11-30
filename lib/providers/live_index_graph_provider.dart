import 'package:biz_alert/features/dashboard/services/dio_dashboard.dart';
import 'package:biz_alert/models/response/live_index_graph_res_model.dart';
import 'package:flutter/material.dart';

class LiveIndexGraphProvider extends ChangeNotifier {
  LiveIndexGraphModel? liveIndexGraph;
  bool loading = false;

  Future<LiveIndexGraphModel>? getLiveIndexGraphData(int indexID) async {
    loading = true;
    liveIndexGraph = await DioDashboard().viewLiveIndexGraph(indexID: indexID);

    loading = false;

    notifyListeners();
    return liveIndexGraph!;
  }
}
