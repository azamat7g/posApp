import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posapp/AppRoutes.dart';
import 'package:posapp/repositories/PosRepository.dart';
import 'package:posapp/services/StorageService.dart';

import '../../BaseController.dart';

class LoginController extends BaseController {
  final phoneInputController = MaskedTextController(mask: "+998 00 000-00-00", text: "+998");
  final passwordInputController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var repo = PosRepository();

  StorageService storage = Get.find();

  String? notEmptyValidator(value) {
    if (value.isEmpty) return 'Обязателное полья';

    return null;
  }

  String? phoneValidator(value) {
    if (value.isEmpty) return "Обязателное полья";

    var regExp = RegExp(r"^\+998 \d{2} \d{3}-\d{2}-\d{2}");
    if (!regExp.hasMatch(value)) return "Неправильный формат";

    return null;
  }

  void login() async {
    if (this.formKey.currentState!.validate()) {
      try {
        this.isLoading.value = true;
        var accessToken = await this.repo.login(this.phoneInputController.text.replaceAll(RegExp(r"[^0-9]"), ""), this.passwordInputController.text);

        this.storage.activeToken = accessToken;
        this.isLoading.value = false;

        Get.offAndToNamed(AppRoutes.HOME);
      } catch (e) {
        this.isLoading.value = false;

        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Неверный логин или пароль'),
          ),
        );
      }
    }
  }
}
