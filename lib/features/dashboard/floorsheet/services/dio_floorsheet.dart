import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/models/response/floorsheet_res_model.dart';
import 'package:dio/dio.dart';

class DioFloorSheet {
  Future<FloorsheetResModel?> viewFloorSheet({
    required int pageNumber,
  }) async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
          "/api/FloorSheet/BrokerFloorsheet?StockSymbol=adbl&BrokerCode=58&BuyOrSale=58&pageNumber=$pageNumber");
      // print(response.data);
      return floorsheetResModelFromJson(response.data!);
    } catch (e) {
      // print("Error viewing floorSheet: $e");
      return null;
    }
  }
}
