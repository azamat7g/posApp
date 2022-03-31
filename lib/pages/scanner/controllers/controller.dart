import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';

import '../../BaseController.dart';

class ScannerController extends BaseController {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  StreamSubscription? streamSubscription;
  bool isChecking = false;
  var isWrongBarcode = false.obs;

  @override
  void onClose() {
    streamSubscription?.cancel();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    streamSubscription = controller.scannedDataStream.listen((barcode) {
      if (this.isChecking) return;

      this.isWrongBarcode.value = false;
      this.isChecking = true;
      String code = barcode.code ?? "";

      RegExp regExp = RegExp(r'^[0-9\s]+$');

      if (regExp.hasMatch(code)) {
        Get.back(result: code);
      } else {
        this.isWrongBarcode.value = false;
      }

      this.isChecking = false;
    });
  }
}
