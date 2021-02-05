import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'bloc/main_bloc.dart';
import 'package:flutter_terrabayt_app/data/widget/widget.dart';

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

class _MainScreenState extends State<MainScreen> {
  MainBloc bloc;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    bloc = BlocProvider.of<MainBloc>(context);
    bloc.add(EventLaunch());
    controller.addListener(() => onScroll());
    super.initState();
  }

  void onScroll() {
    if (bloc.state is StateSuccess == false) return;
    if (!controller.hasClients) return;
    final double maxHeight = controller.position.maxScrollExtent;
    final double currentHeight = controller.offset;
    if (currentHeight >= maxHeight * 0.9) {
      bloc.add(EventNextPage(
        firstUpdate: bloc.postList[bloc.postList.length - 1].publishedAt,
      ));
    }
  }

  @override
  void dispose() {
    bloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) => WBottomLoading(
          visible: state is StateLoading && state.postList.isNotEmpty,
        ),
      ),
      appBar: AppBar(title: Text('Terabayt')),
      drawer: Drawer(
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state is StateLoading)
              return Center(child: SpinKitFadingCircle(color: Colors.grey));
            if (state is FailState)
              return Center(child: Text('${state.message}'));
            if (state is StateSuccess)
              return WDrawer(
                categoryList: state.categoryList,
                onItemPressed: (categoryId) => bloc.add(
                  EventCategoryItemPressed(categoryId: categoryId),
                ),
              );
            return Center(child: Text('Xatolik'));
          },
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is StateLoading)
            return state.postList.isNotEmpty
                ? WBodyList(
                    controller: controller,
                    postList: state.postList,
                    onPressedItem: (index) => bloc.add(
                      EventPostItemPressed(index: index),
                    ),
                  )
                : Center(child: SpinKitFadingCircle(color: Colors.grey));
          if (state is FailState)
            return Center(child: Text('${state.message}'));
          if (state is StateSuccess)
            return WBodyList(
              controller: controller,
              postList: state.postList,
              onPressedItem: (index) => bloc.add(
                EventPostItemPressed(index: index),
              ),
            );
          return Center(child: Text('Xatolik'));
        },
      ),
    );
  }
}
