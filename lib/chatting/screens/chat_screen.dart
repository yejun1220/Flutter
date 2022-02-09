import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_study/chatting/message/message.dart';
import 'package:flutter_study/chatting/message/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser; // 값을 초기화하지 않을 것이므로 ? 을 붙여야 한다.

  @override
  void initState() {
    // 위젯이 생성될 때 처음으로 호출되는 메서드다.
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat screen'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              _authentication.signOut();
              Navigator.pop(context);
            },
          )
        ],
      ),
      // body: Container(
      //   child: Column(
      //     children: [
      //       Expanded(
      //         child: Messages()),
      //       NewMessage()],
      //   ),
      // ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/G6d253stf2YXl9Y7wl1S/message')
            .snapshots(), // snapshots은 Stream을 반환한다.
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(docs[index]['text']),
                );
              });
        }, // AsyncSnapshot은 가장 최신의 snapshot을 가져오게 한다.
      ),
    );
  }
}
