import 'package:biz_alert/features/dashboard/news/news_model.dart';
import 'package:biz_alert/features/dashboard/news/services/dio_news.dart';

class NewsRepository {
  Future<NewModel> getNews() async {
    try {
      final res = await DioNews().getNews();
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
