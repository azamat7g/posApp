import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class StorageService extends GetxService {
  final box = GetStorage();

  var _activeToken = '';

  @override
  void onReady() {
    super.onReady();

    this.loadSettings();
  }

  String get activeToken => this._activeToken;
  set activeToken(String token) {
    this._activeToken = token;

    this._saveToDevice(this.fieldUserToken, token);
  }

  void loadSettings() {
    try {
      this._activeToken = this._loadFromDevice(this.fieldUserToken) ?? '';
    } catch (e) {
      Logger().e(e);
    }
  }

  void _saveToDevice(String key, dynamic value) {
    try {
      box.write(key, jsonEncode(value));
    } catch (e) {
      Logger().e(e);
    }
  }

  dynamic _loadFromDevice(String key) {
    try {
      return jsonDecode(box.read(key));
    } catch (e) {
      Logger().e(e);
    }
  }

  void clearAllData() {
    box.erase();
    this.loadSettings();
  }

  final String fieldUserToken = '_ut';
}
