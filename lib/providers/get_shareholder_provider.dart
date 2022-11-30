import 'package:biz_alert/features/dashboard/protfolio/services/dio_protfolio.dart';
import 'package:biz_alert/models/response/get_shareholder_res.dart';
import 'package:flutter/cupertino.dart';

class ShareHolderProvider extends ChangeNotifier {
  GetShareHolderResponseModel? getShareHolderModel;
  bool loading = false;

  Future<GetShareHolderResponseModel>? getShareHolder() async {
    loading = true;
    getShareHolderModel = await DioPortfolioChart().viewShareHolder();

    loading = false;

    notifyListeners();
    return getShareHolderModel!;
  }
}
