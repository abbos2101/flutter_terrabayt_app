import 'dart:math';

import 'package:flutter/material.dart';

class WFail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int rand = Random().nextInt(2) + 1;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/error$rand.gif'),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular((rand - 1) * 80.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
