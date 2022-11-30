import 'package:biz_alert/features/dashboard/news/news_model.dart';
import 'package:biz_alert/features/dashboard/news/news_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _newsRepository;
  NewsCubit(this._newsRepository) : super(NewsInitial());

  void onLoad() => emit(NewSuccess(_newsRepository.getNews()));

  void onFailed() => emit(const NewFailure("Error occured"));
}
