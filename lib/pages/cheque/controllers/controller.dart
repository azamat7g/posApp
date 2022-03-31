import 'package:get/get.dart';
import 'package:posapp/models/Product.dart';

import '../../BaseController.dart';

class ChequeController extends BaseController {
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments == null) {
      Get.back();
    }

    this.products.value = Get.arguments;
  }
}
