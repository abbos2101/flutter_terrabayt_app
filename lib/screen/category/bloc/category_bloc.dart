import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_terrabayt_app/data/model/post_model.dart';
import 'package:flutter_terrabayt_app/data/net/dio_service.dart';
import 'package:flutter_terrabayt_app/di/locator.dart';
import 'package:flutter_terrabayt_app/screen/content/content_screen.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final DioService _dioService = locator.get<DioService>();
  final BuildContext context;
  final int id;
  final String name;
  final String slug;

  CategoryBloc({this.context, this.id, this.name, this.slug})
      : super(StateLoading(postList: []));

  List<PostModel> postList = [];

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is EventLaunch)
      yield* _eventLaunch(event);
    else if (event is EventPostItemPressed)
      yield* _eventPostItemPressed(event);
    else if (event is EventNextPage) yield* _eventNextPage(event);
  }

  Stream<CategoryState> _eventLaunch(EventLaunch event) async* {
    try {
      postList = await _dioService.getPostList(category: id);
      yield StateSuccess(postList: postList);
    } catch (e) {
      yield StateFail(message: '$e');
    }
  }

  Stream<CategoryState> _eventPostItemPressed(
      EventPostItemPressed event) async* {
    Navigator.push(
      context,
      ContentScreen.route(postModel: postList[event.index]),
    );
  }

  Stream<CategoryState> _eventNextPage(EventNextPage event) async* {
    yield StateLoading(postList: postList);
    try {
      (await _dioService.getPostList(
        category: id,
        firstUpdate: event.firstUpdate,
      ))
          .forEach((it) => postList.add(it));
      yield StateSuccess(postList: postList);
    } catch (e) {
      yield StateFail(message: '$e');
    }
  }
}
