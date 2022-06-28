import 'package:get/get.dart';

import '../model/product.dart';

class ShoppingController extends GetxController {
  var products = <Product>[
    Product(id: 6, productName: 'Test', productDescription: 'some description about product', price: 20),
    Product(id: 6, productName: 'Test', productDescription: 'some description about product', price: 20),
    Product(id: 6, productName: 'Test', productDescription: 'some description about product', price: 20),
    Product(id: 6, productName: 'Test', productDescription: 'some description about product', price: 20),
    Product(id: 6, productName: 'Test', productDescription: 'some description about product', price: 20),
  ].obs;

  // Controller가 생성될 때 실행되는 메서드
  @override
  void onInit() async {
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(seconds: 2));

    var productData = [
      Product(id: 1, productName: 'Mouse', productDescription: 'some description about product', price: 30),
      Product(id: 2, productName: 'Keyboard', productDescription: 'some description about product', price: 40),
      Product(id: 3, productName: 'Monitor', productDescription: 'some description about product', price: 620),
      Product(id: 4, productName: 'Ram', productDescription: 'some description about product', price: 80),
      Product(id: 5, productName: 'Speaker', productDescription: 'some description about product', price: 120.5),
    ];

    // Iterable 타입의 변수를 인자로 넘겨줘야 한다.
    // 현재 리스트 내에 있는 모든 아이템을 인자값으로 대체시켜준다.
    products.assignAll(productData);
  }
}
