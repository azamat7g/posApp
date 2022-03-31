import 'package:get/get.dart';
import 'package:posapp/AppRoutes.dart';
import 'package:posapp/pages/cheque/bindings/binding.dart';
import 'package:posapp/pages/cheque/views/view.dart';
import 'package:posapp/pages/history/bindings/binding.dart';
import 'package:posapp/pages/history/views/view.dart';
import 'package:posapp/pages/home/bindings/binding.dart';
import 'package:posapp/pages/home/views/view.dart';
import 'package:posapp/pages/launcher/bindings/binding.dart';
import 'package:posapp/pages/launcher/views/view.dart';
import 'package:posapp/pages/login/bindings/binding.dart';
import 'package:posapp/pages/login/views/view.dart';
import 'package:posapp/pages/scanner/bindings/binding.dart';
import 'package:posapp/pages/scanner/views/view.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.BASE,
      page: () => const LauncherPage(),
      binding: LauncherBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.CHEQUE,
      page: () => const ChequePage(),
      binding: ChequeBinding(),
    ),
    GetPage(
      name: AppRoutes.SCANNER,
      page: () => const ScannerPage(),
      binding: ScannerBinding(),
    ),
    GetPage(
      name: AppRoutes.HISTORY,
      page: () => const HistoryPage(),
      binding: HistoryBinding(),
    ),
  ];
}
