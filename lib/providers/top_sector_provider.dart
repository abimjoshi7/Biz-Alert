import 'package:biz_alert/features/dashboard/services/dio_dashboard.dart';
import 'package:biz_alert/models/response/top_sector_res_model.dart';
import 'package:flutter/material.dart';

class TopSectorProvider extends ChangeNotifier {
  TopSectorModel? topSector;
  bool loading = false;

  Future<TopSectorModel>? getTopSectorData() async {
    loading = true;
    topSector = await DioDashboard().viewTopSector();

    loading = false;

    notifyListeners();
    return topSector!;
  }
}
