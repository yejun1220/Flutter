import 'package:flutter/material.dart';
import 'package:flutter_study/coding_chef/level2/view/mypage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPage(),
    );
  }
}
