import 'package:flutter/material.dart';

class FishModel with ChangeNotifier {
  final String name;
  int quantity;
  final String size;

  FishModel({required this.name, required this.quantity, required this.size});

  void changeFishNumber() {
    quantity++;
    notifyListeners();
  }
}
