import 'package:logger/logger.dart';
import 'package:posapp/models/History.dart';
import 'package:posapp/repositories/PosRepository.dart';
import 'package:get/get.dart';

import '../../BaseController.dart';

class HistoryController extends BaseController {
  var repo = PosRepository();
  var history = <History>[].obs;

  @override
  void onReady() {
    super.onReady();

    this.loadHistory();
  }

  void loadHistory() async {
    try {
      this.isLoading.value = true;
      this.history.value = await this.repo.getHistory();

      Logger().w(this.history);

      this.isLoading.value = false;
    } catch (e) {
      Logger().e(e);
      this.isLoading.value = false;
    }
  }
}
