import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_terrabayt_app/data/model/post_model.dart';

class WBodyList extends StatelessWidget {
  final ScrollController controller;
  final List<PostModel> postList;
  final Function(int index) onPressedItem;

  WBodyList({this.postList, this.controller, this.onPressedItem});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: controller,
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
                placeholder: (_, url) => Center(
                  child: SpinKitFadingCircle(color: Colors.grey),
                ),
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
                      placeholder: (_, url) => Center(
                          child: SpinKitFadingCircle(color: Colors.grey)),
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
}
