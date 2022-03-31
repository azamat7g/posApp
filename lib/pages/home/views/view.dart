import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:posapp/AppRoutes.dart';
import 'package:posapp/models/Product.dart';
import '../controllers/controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("POS app"),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.HISTORY),
            icon: const Icon(Icons.list),
          ),
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: controller.formKey,
                        child: TextFormField(
                          controller: controller.searchInputController,
                          autocorrect: false,
                          validator: (value) => controller.notEmptyValidator(value),
                          decoration: const InputDecoration(
                            labelText: "Названия продукта",
                          ),
                          onFieldSubmitted: (value) => controller.searchByKeyword(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: controller.scanBarcode,
                      icon: const Icon(
                        Icons.document_scanner,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: (controller.isLoading.value)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : (controller.productsList.isNotEmpty)
                      ? ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
                          itemCount: controller.productsList.length,
                          itemBuilder: (c, index) {
                            Product item = controller.productsList[index];

                            return ListTile(
                              selectedTileColor: Colors.green.withOpacity(0.8),
                              selectedColor: Colors.white,
                              selected: controller.selectedProducts.keys.contains(item.id),
                              title: Text(item.name),
                              trailing: Text(item.price.toString()),
                              onTap: () => controller.selectProduct(item),
                            );
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.local_grocery_store_outlined, size: 100, color: Colors.grey),
                            Text("Пусто", style: TextStyle(fontSize: 28, color: Colors.grey))
                          ],
                        ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              color: Colors.white,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: (controller.selectedProducts.isNotEmpty) ? Colors.green : Colors.grey),
                child: Text(
                  "Оплатить: ${controller.selectedProducts.length}",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: (controller.selectedProducts.isNotEmpty) ? controller.buy : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
