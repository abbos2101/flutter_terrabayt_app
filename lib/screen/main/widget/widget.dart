import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_terrabayt_app/data/model/category_model.dart';
import 'package:flutter_terrabayt_app/data/model/post_model.dart';

mixin MainWidgetImp {
  Widget widgetBodyList({
    List<PostModel> postList,
    void onPressedItem(int index),
  }) {
    return ListView.builder(
      itemCount: (postList ?? []).length,
      itemBuilder: (_, i) {
        final String title = postList[i].title;
        final String category = postList[i].categoryName;
        final String modified = postList[i].postModified;
        final String image = postList[i].image;

        if (i % 5 == 0)
          return Card(
              child: Stack(
            children: [
              CachedNetworkImage(
                height: 258,
                imageUrl: image,
                fit: BoxFit.fill,
                placeholder: (_, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (_, url, error) => Icon(Icons.error),
              ),
              MaterialButton(
                padding: EdgeInsets.all(4),
                onPressed: () => onPressedItem(i),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  height: 250,
                  padding: EdgeInsets.all(4),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '$title',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ],
          ));
        return Card(
          child: MaterialButton(
            padding: EdgeInsets.all(5),
            onPressed: onPressedItem == null ? null : () => onPressedItem(i),
            child: SizedBox(
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      height: 120,
                      fit: BoxFit.fill,
                      imageUrl: image,
                      placeholder: (_, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (_, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: Text(
                            '$title',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              '$category',
                              style: TextStyle(fontSize: 13),
                            )),
                            Text(
                              '$modified',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget widgetDrawer({
    List<CategoryModel> categoryList,
    void onItemPressed(int categoryId),
  }) {
    return Container(
      color: Colors.grey,
      child: ListView.builder(
        itemCount: categoryList.length + 1,
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
                onPressed: () => onItemPressed(categoryList[i - 2].id),
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
