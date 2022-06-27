import 'package:flutter/material.dart';
import 'package:flutter_study/getx/controller.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GetX'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 어떤 타입의 데이터를 사용할지 알려줘야 한다.
              GetBuilder<Controller>(
                init: Controller(),
                // builder는 function을 파라미터로 가진다.
                builder: (_) => Text(
                  'Current value is ${Get.find<Controller>().x}',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ), // state를 화면에 다시 그려 주는 역할
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.find<Controller>().increment();
                },
                child: Text('Add number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
