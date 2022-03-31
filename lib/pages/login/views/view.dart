import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("POS app"),),
      body: Center(
        child: Obx(
          () => (controller.isLoading.value)
              ? const CircularProgressIndicator()
              : Container(
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Авторизация",
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controller.phoneInputController,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          validator: (value) => controller.phoneValidator(value),
                          decoration: const InputDecoration(
                            labelText: "Номер телефона",
                            hintText: "+998 90 900-00-00",
                          ),
                        ),
                        TextFormField(
                          controller: controller.passwordInputController,
                          autocorrect: false,
                          obscureText: true,
                          enableSuggestions: false,
                          validator: (value) => controller.notEmptyValidator(value),
                          decoration: const InputDecoration(
                            labelText: "Пароль",
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: controller.login,
                          child: const Text("Войти"),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
