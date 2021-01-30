import 'package:flutter/material.dart';
import 'di/locator.dart';
import 'screen/main/main_screen.dart';

void main() {
  locatorSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.grey,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          color: Colors.black,
          foregroundColor: Colors.white,
          backwardsCompatibility: false,
        ),
      ),
      home: MainScreen.screen(),
    );
  }
}
