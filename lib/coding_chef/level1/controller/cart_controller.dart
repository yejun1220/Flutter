import 'package:get/get.dart';

import '../model/product.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  double get totalPrice => cartItems.fold(0, (previousValue, product) => previousValue + product.price);
  int get count => cartItems.length;

  void addItem(Product product) {
    cartItems.add(product);
  }
}
