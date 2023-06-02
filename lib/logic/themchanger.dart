import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemModeChange extends GetxController {
  ThemeMode themeMode = ThemeMode.system;

  bool isDarkMode(BuildContext context) {
    if (themeMode == ThemeMode.system) {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void switchTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    update();
  }
}
