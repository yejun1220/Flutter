import 'package:flutter_study/coding_chef/level2/model/product.dart';
import 'package:get/get.dart';

import '../data/services.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    var products = await Services.fetchProducts();
    if (products != null) {
      productList.value = products;
      isLoading.value = false;
    } else {
      isLoading.value = true;
    }
  }
}
