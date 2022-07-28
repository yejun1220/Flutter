import 'package:get/get.dart';

import '../model/product.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  int get count => cartItems.length;

  void addItem(Product product) {
    cartItems.add(product);
  }

  void deleteItem(Product product) {
    cartItems.remove(product);
  }
}
