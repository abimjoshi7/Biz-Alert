import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/models/response/get_today_shareprice_res_model.dart';
import 'package:biz_alert/models/response/live_market_trading_res_model.dart';
import 'package:dio/dio.dart';

class DioLiveMarketTrading {
//View Dashboard Data
  Future<LiveMarketTradingModel?> viewLiveTrading() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Market/LiveTrading?userAuth.id=1", //$id,
      );
      // print(response.data);
      return liveMarketTradingModelFromJson(response.data!);
    } catch (e) {
      // print('Error viewing live market data: $e');
      return null;
    }
  }

  // Todays Share Price
  Future<GetTodaysSharePriceResponseModel?> viewTodaySharePrice(
      {required int pageNumber}) async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Market/TodaysSharprice?pageNumber=$pageNumber", //$id,
      );
      // print(response.data);
      return getTodaysSharePriceResponseModelFromJson(response.data!);
    } catch (e) {
      // print('Error viewing todays share price: $e');
      return null;
    }
  }
}
