part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewSuccess extends NewsState {
  final Future<NewModel> newModel;

  const NewSuccess(this.newModel);

  @override
  List<Object?> get props => [newModel];
}

class NewFailure extends NewsState {
  final String error;

  const NewFailure(this.error);

  @override
  List<Object?> get props => [error];
}
