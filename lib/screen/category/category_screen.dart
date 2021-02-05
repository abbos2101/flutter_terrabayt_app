import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'bloc/category_bloc.dart';
import 'package:flutter_terrabayt_app/data/widget/widget.dart';

class CategoryScreen extends StatefulWidget {
  static MaterialPageRoute route({int id, String name, String slug}) =>
      MaterialPageRoute(builder: (_) => screen(id: id, name: name, slug: slug));

  static Widget screen({int id, String name, String slug}) => BlocProvider(
        create: (context) => CategoryBloc(
          context: context,
          id: id,
          name: name,
          slug: slug,
        ),
        child: CategoryScreen(),
      );

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController controller = ScrollController();
  CategoryBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CategoryBloc>(context);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("${bloc.name}")),
      bottomSheet: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) => WBottomLoading(
          visible: state is StateLoading && state.postList.isNotEmpty,
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is StateLoading) {
            return state.postList.isNotEmpty
                ? WBodyList(
                    postList: state.postList,
                    onPressedItem: (index) => bloc.add(
                      EventPostItemPressed(index: index),
                    ),
                    controller: controller,
                  )
                : Center(child: SpinKitFadingCircle(color: Colors.grey));
          }
          if (state is StateFail) return WFail();
          if (state is StateSuccess)
            return WBodyList(
              postList: state.postList,
              onPressedItem: (index) => bloc.add(
                EventPostItemPressed(index: index),
              ),
              controller: controller,
            );
          return WFail();
        },
      ),
    );
  }
}
