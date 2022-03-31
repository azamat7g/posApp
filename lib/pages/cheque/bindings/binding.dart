import '../controllers/controller.dart';
import 'package:get/get.dart';

class ChequeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChequeController());
  }
}
