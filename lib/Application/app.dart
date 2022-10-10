import 'package:flutter/material.dart';

import '../main.dart';

class MyApp extends StatelessWidget {
  // private constructor
  MyApp._();
  // private instance
  static MyApp? _app;
  factory MyApp () {
    return _app ?? MyApp._();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
