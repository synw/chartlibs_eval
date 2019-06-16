import 'package:flutter/material.dart';
import 'conf.dart';
import 'pages/index.dart';

final routes = {
  '/index': (BuildContext context) => IndexPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chart libs evaluation',
      routes: routes,
      home: IndexPage(),
    );
  }
}

void main() {
  initConf();
  runApp(MyApp());
}
