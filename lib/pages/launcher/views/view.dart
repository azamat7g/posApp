import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/controller.dart';

class LauncherPage extends GetView<LauncherController> {
  const LauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
