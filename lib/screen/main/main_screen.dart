import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/main_bloc.dart';
import 'widget/widget.dart';

class MainScreen extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (_) => screen());

  static Widget screen() => BlocProvider(
        create: (context) => MainBloc(context),
        child: MainScreen(),
      );

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with MainWidgetImp {
  MainBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<MainBloc>(context);
    bloc.add(LaunchEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terabayt'),
        backgroundColor: Colors.grey,
      ),
      drawer: Drawer(
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state is LoadingState)
              return Center(child: CircularProgressIndicator());
            if (state is FailState)
              return Center(child: Text('${state.message}'));
            if (state is SuccessState)
              return widgetDrawer(
                categoryList: state.categoryList,
                onItemPressed: (categoryId) => bloc.add(
                  CategoryItemPressedEvent(categoryId: categoryId),
                ),
              );
            return Center(child: Text('Xatolik'));
          },
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is LoadingState)
            return Center(child: CircularProgressIndicator());
          if (state is FailState)
            return Center(child: Text('${state.message}'));
          if (state is SuccessState)
            return widgetBodyList(
              postList: state.postList,
              onPressedItem: (index) => bloc.add(
                PostItemPressedEvent(index: index),
              ),
            );
          return Center(child: Text('Xatolik'));
        },
      ),
    );
  }
}
