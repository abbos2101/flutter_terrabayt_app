part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends MainState {}

class FailState extends MainState {
  final String message;

  FailState({this.message});

  @override
  List<Object> get props => [message];
}

class SuccessState extends MainState {
  final List<CategoryModel> categoryList;
  final List<PostModel> postList;

  SuccessState({this.categoryList, this.postList});

  @override
  List<Object> get props => [categoryList, postList];
}
