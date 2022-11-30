import 'package:biz_alert/features/dashboard/news/news_model.dart';
import 'package:dio/dio.dart';

class DioNews {
  Future<NewModel> getNews() async {
    final res = await Dio().get(
        "https://api.marketaux.com/v1/news/all?api_token=8ZVLe0A3EL0dEpQ5bYRZS8jlwUX9bQd3s2DqjGcg");
    return NewModel.fromJson(res.data);
  }
}
