import 'package:flutter/material.dart';

class SeaFishModel with ChangeNotifier {
  final String name;
  int seaQuantity;
  final String size;

  SeaFishModel({required this.name, required this.seaQuantity, required this.size});

  void changeSeaFishNumber() {
    seaQuantity++;
    notifyListeners();
  }
}
