import 'package:biz_alert/features/dashboard/services/dio_dashboard.dart';
import 'package:biz_alert/models/response/get_indices_res_model.dart';
import 'package:flutter/material.dart';

class GetIndicesProvider extends ChangeNotifier {
  GetIndicesModel? getIndices;
  bool loading = false;

  Future<GetIndicesModel>? getIndicesData() async {
    loading = true;
    getIndices = await DioDashboard().viewIndices();

    loading = false;

    notifyListeners();
    return getIndices!;
  }
}
