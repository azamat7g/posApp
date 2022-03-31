import 'package:get/get.dart';
import 'package:posapp/services/StorageService.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageService());
  }
}
