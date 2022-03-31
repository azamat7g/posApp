import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/controller.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("История"),
      ),
      body: Center(
        child: Obx(
          () => (controller.isLoading.value)
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.yellow,
                      ),
                      child: const Text(
                        "АПИ \"/sales/show?sale_id=\$id\" был для меня непонятен. Почему то АПИ не возвращает названии продуктов. Возвращает только их ID номера. А как получить названия по ID не описано",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
                          itemCount: controller.history.length,
                          itemBuilder: (c, index) {
                            var item = controller.history[index];

                            return ListTile(
                              title: Text("Кассир: ${item.cashier}"),
                              subtitle: Text("Количество продуктов: ${item.amount}"),
                              trailing: Text(item.sum.toString()),
                            );
                          }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
