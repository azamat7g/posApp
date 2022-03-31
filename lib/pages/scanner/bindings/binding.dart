import '../controllers/controller.dart';
import 'package:get/get.dart';

class ScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScannerController());
  }
}
