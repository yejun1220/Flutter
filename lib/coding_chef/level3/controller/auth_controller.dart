import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/coding_chef/level3/screen/login.dart';
import 'package:get/get.dart';

import '../screen/welcome.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find<AuthController>();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => WelcomePage());
    }
  }

  void register(String email, String password) async {
    try {
      await authentication.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        titleText: Text("Registration is failed"),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void logout() {
    authentication.signOut();
  }

  void login(String email, String password) async {
    isLoading.value = true;
    try {
      await authentication.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        titleText: Text("login is failed"),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    isLoading.value = false;
  }
}
