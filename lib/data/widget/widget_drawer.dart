import 'package:flutter/material.dart';
import 'package:flutter_terrabayt_app/data/model/category_model.dart';

class WDrawer extends StatelessWidget {
  final List<CategoryModel> categoryList;
  final Function(int categoryId) onItemPressed;

  WDrawer({this.categoryList, this.onItemPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: ListView.builder(
        itemCount: categoryList.length + 2,
        itemBuilder: (context, i) {
          if (i == 0)
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/tera_full_logo.png', height: 100),
            );
          if (i == 1) return Divider(height: 1, color: Colors.black38);
          return Column(
            children: [
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () => onItemPressed(i - 2),
                padding: EdgeInsets.all(0),
                child: Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${categoryList[i - 2].name}',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.black38),
            ],
          );
        },
      ),
    );
  }
}
