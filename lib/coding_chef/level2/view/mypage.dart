import 'package:flutter/material.dart';
import 'package:flutter_study/coding_chef/level2/view/product_tile.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);

  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: Colors.black87,
        elevation: 0,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.view_list_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Obx(() {
            if (productController.isLoading.value) return Center(child: CircularProgressIndicator());
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ProductTile(productController.productList[index]);
              },
              itemCount: productController.productList.length,
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: GetX<CartController>(builder: (controller) {
          return Text(
            controller.count.toString(),
            style: TextStyle(fontSize: 20),
          );
        }),
        icon: Icon(Icons.shopping_cart_rounded),
        backgroundColor: Colors.red,
      ),
    );
  }
}
