import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posapp/AppRoutes.dart';
import 'package:posapp/models/Product.dart';
import 'package:posapp/repositories/PosRepository.dart';
import 'package:posapp/services/StorageService.dart';

import '../../BaseController.dart';

class HomeController extends BaseController {
  var repo = PosRepository();
  var searchInputController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var productsList = <Product>[].obs;
  var selectedProducts = <int, Product>{}.obs;

  StorageService storage = Get.find();

  String? notEmptyValidator(value) {
    if (value.isEmpty) return 'Обязателное полья';

    return null;
  }

  void searchByKeyword() async {
    if (this.formKey.currentState!.validate()) {
      try {
        this.isLoading.value = true;
        this.selectedProducts.clear();
        this.productsList.value = await this.repo.query(this.searchInputController.text);

        this.isLoading.value = false;
      } catch (e) {
        this.isLoading.value = false;
      }
    }
  }

  void searchByBarcode(String barcode) async {
    try {
      this.isLoading.value = true;
      this.selectedProducts.clear();
      var result = await this.repo.queryByBarcode(barcode);
      this.productsList.add(result);

      this.isLoading.value = false;
    } catch (e) {
      this.isLoading.value = false;
    }
  }

  void selectProduct(Product item) {
    if (this.selectedProducts.containsKey(item.id)) {
      this.selectedProducts.remove(item.id);
    } else {
      this.selectedProducts[item.id] = item;
    }

    this.selectedProducts.update(item.id, (v) => item);
  }

  void buy() {
    Get.toNamed(AppRoutes.CHEQUE, arguments: this.selectedProducts.values.toList());
  }

  void scanBarcode() async {
    var code = await Get.toNamed(AppRoutes.SCANNER);

    Logger().w(code);
    this.searchByBarcode(code);
  }

  void logout() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выход'),
          content: const Text('Вы действительно хотите выйти из аккаунта?'),
          actions: [
            TextButton(
              child: const Text('Нет'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Да'),
              onPressed: () {
                this.storage.clearAllData();
                Get.back();

                this.repo.logout();
                Get.offAndToNamed(AppRoutes.LOGIN);
              },
            ),
          ],
        );
      },
    );
  }
}
