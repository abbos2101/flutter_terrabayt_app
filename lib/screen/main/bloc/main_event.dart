part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventLaunch extends MainEvent {}

class EventPostItemPressed extends MainEvent {
  final int index;

  EventPostItemPressed({this.index});

  @override
  List<Object> get props => [index];
}

class EventCategoryItemPressed extends MainEvent {
  final int categoryId;

  EventCategoryItemPressed({this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class EventNextPage extends MainEvent {
  final int firstUpdate;

  EventNextPage({this.firstUpdate});

  @override
  List<Object> get props => [firstUpdate];
}
