part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventLaunch extends CategoryEvent {}

class EventPostItemPressed extends CategoryEvent {
  final int index;

  EventPostItemPressed({this.index});

  @override
  List<Object> get props => [index];
}

class EventNextPage extends CategoryEvent {
  final int firstUpdate;

  EventNextPage({this.firstUpdate});

  @override
  List<Object> get props => [firstUpdate];
}
