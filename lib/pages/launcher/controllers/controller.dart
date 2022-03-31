import 'package:get/get.dart';
import 'package:posapp/AppRoutes.dart';
import 'package:posapp/services/StorageService.dart';

import '../../BaseController.dart';

class LauncherController extends BaseController {
  StorageService storage = Get.find();

  @override
  void onReady() {
    super.onReady();

    if (this.storage.activeToken.isNotEmpty) {
      Get.offAndToNamed(AppRoutes.HOME);
    } else {
      Get.offAndToNamed(AppRoutes.LOGIN);
    }
  }
}
