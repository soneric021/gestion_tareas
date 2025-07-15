import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeController {
  final _themeBox = Hive.box("theme_manager");

  bool getTheme(){
    return _themeBox.get("isDarkMode") == true;
  }

  Future<void> setTheme(bool isDarkMode) async {
    _themeBox.put("isDarkMode", isDarkMode);
  }

}