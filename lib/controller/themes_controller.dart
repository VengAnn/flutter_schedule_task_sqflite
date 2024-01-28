import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = "isDarkMode";

  bool _isDark = false;
  bool get isDark => _isDark;

  void toggleDarkLigthMode(bool valueMode) {
    _isDark = valueMode;
    // tell UI immedialy
    update();
    debugPrint(_isDark.toString());
    saveThemesLocalStorage();
  }

  void saveThemesLocalStorage() {
    _box.write(_key, _isDark);
    final isDark = _box.read(_key);
    // ignore: avoid_print
    print("isDark: $isDark");
  }

  void loadTheme() {
    final isDark = _box.read(_key);
    if (isDark != null) {
      // pass local storage to load dark or ligth mode
      _isDark = isDark;
    }
  }
}
