part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateLoading extends CategoryState {
  final List<PostModel> postList;

  StateLoading({this.postList});

  @override
  List<Object> get props => [postList];
}

class StateSuccess extends CategoryState {
  final List<PostModel> postList;

  StateSuccess({this.postList});

  @override
  List<Object> get props => [postList];
}

class StateFail extends CategoryState {
  final String message;

  StateFail({this.message});

  @override
  List<Object> get props => [message];
}
