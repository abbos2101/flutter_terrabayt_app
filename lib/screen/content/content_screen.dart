import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  static MaterialPageRoute route({String data, String title}) =>
      MaterialPageRoute(builder: (_) => screen(data: data, title: title));

  static Widget screen({String data, String title}) =>
      ContentScreen(data, title);

  final String data;
  final String title;

  const ContentScreen(this.data, this.title);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.title}')),
      body: SingleChildScrollView(child: Text('${widget.data}')),
    );
  }
}
