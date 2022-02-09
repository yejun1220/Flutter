import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final int price = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 기본 틀 위젯(앱 바 등)
      appBar: AppBar(
        title: Text('Stream builder'),
      ),
      body: StreamBuilder<int>( // 위젯이므로 body에 넣을 수 있다. stream으로 전달되는 데이터를 구독할 수 있다.
        initialData: price, // 기본 값
        stream: addStreamValue(), // Stream 타입 저장
        builder: (context, snapshot) {  // snapshot은 stream의 결과물이다. streambuilder에게 인자로 전달한 snapshot을 이용하라는 의미이다.
          final priceNumber = snapshot.data.toString();
          return Center(
            child: Text(
              priceNumber,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.blue),
            ),
          );
        },
      ),
    );
  }

  Stream<int> addStreamValue() {
    return Stream<int>.periodic(
        // 일정 시간마다 데이터(이벤트)를 만든다.
        Duration(seconds: 3),
        (count) => price + count);
  }
}
