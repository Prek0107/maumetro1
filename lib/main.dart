import 'package:flutter/material.dart';
import 'package:maumetro/root.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MauMetro',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: WelcomePage(),
    );
  }
}
