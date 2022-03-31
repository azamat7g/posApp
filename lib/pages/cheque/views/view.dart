import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import '../controllers/controller.dart';

class ChequePage extends GetView<ChequeController> {
  const ChequePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Чек"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Obx(
            () => Column(
              children: [
                ...controller.products
                    .map(
                      (item) => ListTile(
                        title: Text("${item.name} x1"),
                        trailing: Text(item.price.toString()),
                      ),
                    )
                    .toList(),
                const Divider(),
                ListTile(
                  title: const Text("Итого", style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Text(
                    controller.products.sumBy((element) => element.price).toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
