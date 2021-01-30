import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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

  MainBloc(this.context) : super(LoadingState());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is LaunchEvent)
      yield* _eventLaunch(event);
    else if (event is PostItemPressedEvent)
      yield* _eventPostItemPressed(event);
    else if (event is CategoryItemPressedEvent)
      yield* _eventCategoryItemPressed(event);
  }

  List<PostModel> postList = [];
  List<CategoryModel> categoryList = [];

  Stream<MainState> _eventLaunch(LaunchEvent event) async* {
    try {
      postList = await _dioService.getPostList();
      categoryList = await _dioService.getCategoryList();
      yield SuccessState(postList: postList, categoryList: categoryList);
    } catch (e) {
      yield FailState(message: '$e');
    }
  }

  Stream<MainState> _eventPostItemPressed(PostItemPressedEvent event) async* {
    Navigator.push(
        context,
        ContentScreen.route(
          data: postList[event.index].content,
          title: postList[event.index].categoryName,
        ));
  }

  Stream<MainState> _eventCategoryItemPressed(
      CategoryItemPressedEvent event) async* {
    print(event.categoryId);
    Navigator.push(context, CategoryScreen.route());
  }
}
