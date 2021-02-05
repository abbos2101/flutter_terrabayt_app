part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateLoading extends MainState {
  final List<CategoryModel> categoryList;
  final List<PostModel> postList;

  StateLoading({this.categoryList, this.postList});

  @override
  List<Object> get props => [categoryList, postList];
}

class FailState extends MainState {
  final String message;

  FailState({this.message});

  @override
  List<Object> get props => [message];
}

class StateSuccess extends MainState {
  final List<CategoryModel> categoryList;
  final List<PostModel> postList;

  StateSuccess({this.categoryList, this.postList});

  @override
  List<Object> get props => [categoryList, postList];
}
