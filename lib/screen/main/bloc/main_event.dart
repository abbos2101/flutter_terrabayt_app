part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LaunchEvent extends MainEvent {}

class PostItemPressedEvent extends MainEvent {
  final int index;

  PostItemPressedEvent({this.index});
}

class CategoryItemPressedEvent extends MainEvent {
  final int categoryId;

  CategoryItemPressedEvent({this.categoryId});
}
