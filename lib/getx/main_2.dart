import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'personal_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: PersonalCard(),
    );
  }
}
