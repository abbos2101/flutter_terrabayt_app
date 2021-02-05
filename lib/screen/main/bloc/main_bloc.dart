import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_terrabayt_app/data/model/category_model.dart';
import 'package:flutter_terrabayt_app/data/model/post_model.dart';
import 'package:flutter_terrabayt_app/data/net/dio_service.dart';
import 'package:flutter_terrabayt_app/di/locator.dart';
import 'package:flutter_terrabayt_app/screen/category/category_screen.dart';
import 'package:flutter_terrabayt_app/screen/content/content_screen.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final DioService _dioService = locator.get<DioService>();
  final BuildContext context;

  MainBloc(this.context) : super(StateLoading(categoryList: [], postList: []));

  List<PostModel> postList = [];
  List<CategoryModel> categoryList = [];

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is EventLaunch)
      yield* _eventLaunch(event);
    else if (event is EventPostItemPressed)
      yield* _eventPostItemPressed(event);
    else if (event is EventCategoryItemPressed)
      yield* _eventCategoryItemPressed(event);
    else if (event is EventNextPage) yield* _eventNextPage(event);
  }

  Stream<MainState> _eventLaunch(EventLaunch event) async* {
    try {
      postList = await _dioService.getPostList();
      categoryList = await _dioService.getCategoryList();
      yield StateSuccess(postList: postList, categoryList: categoryList);
    } catch (e) {
      yield FailState(message: '$e');
    }
  }

  Stream<MainState> _eventPostItemPressed(EventPostItemPressed event) async* {
    Navigator.push(
      context,
      ContentScreen.route(postModel: postList[event.index]),
    );
  }

  Stream<MainState> _eventCategoryItemPressed(
      EventCategoryItemPressed event) async* {
    CategoryModel model = categoryList[event.categoryId];
    Navigator.push(
      context,
      CategoryScreen.route(id: model.id, name: model.name, slug: model.slug),
    );
  }

  Stream<MainState> _eventNextPage(EventNextPage event) async* {
    yield StateLoading(categoryList: categoryList, postList: postList);
    try {
      (await _dioService.getPostList(firstUpdate: event.firstUpdate)).forEach(
        (it) => postList.add(it),
      );
      yield StateSuccess(postList: postList, categoryList: categoryList);
    } catch (e) {
      yield FailState(message: '$e');
    }
  }
}
