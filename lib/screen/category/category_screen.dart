import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/category_bloc.dart';

class CategoryScreen extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (_) => screen());

  static Widget screen() => BlocProvider(
        create: (_) => CategoryBloc(),
        child: CategoryScreen(),
      );

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
