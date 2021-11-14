import 'package:flutter/material.dart';
import 'package:manga_app/module/chapter_screen.dart';
//import 'package:merdga/screens/DetailScreen.dart';
import 'module/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manga reader',
      home: HomeScreen(),
    );
  }
}
