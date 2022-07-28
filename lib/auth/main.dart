import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_study/auth/chat_screen.dart';
import 'package:flutterfire_ui/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Authentication(),
    );
  }
}

class Authentication extends StatelessWidget{
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // 사용자가 로그인, 로그아웃을 할 때마다 Authentication State가 변할 것이고, 이를 구독(stream)하고 있다가 builder 메서드를 통해 새롭게 랜더링해준다.
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return SignInScreen(providerConfigs: [
                EmailProviderConfiguration()
              ]);
            }
            return ChatScreen();
        });
  }

}

