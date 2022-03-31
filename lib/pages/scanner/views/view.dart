import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../controllers/controller.dart';

class ScannerPage extends GetView<ScannerController> {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    double min = (size.width < size.height) ? size.width : size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Сканер")),
      body: Obx(() => Stack(
            alignment: Alignment.center,
            children: [
              QRView(
                key: controller.qrKey,
                onQRViewCreated: (qrViewController) {
                  controller.onQRViewCreated(qrViewController);
                },
                overlay: QrScannerOverlayShape(
                  cutOutSize: min * 0.7,
                  borderWidth: 10,
                  borderLength: 20,
                  borderRadius: 10,
                  borderColor: Colors.blue,
                ),
              ),
              Positioned(
                bottom: 50,
                child: controller.isWrongBarcode.value
                    ? Container(
                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        child: Text('Неправильный код'.tr),
                      )
                    : Container(),
              )
            ],
          )),
    );
  }
}
