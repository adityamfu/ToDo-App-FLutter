import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'IsDarkMode';

  _saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool _loadThemeData() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeData() ? ThemeMode.dark : ThemeMode.light;
  
  // Menggunakan properti theme untuk memeriksa status dark/light mode
  bool get isDarkMode => _loadThemeData();

  void switchTheme() {
    Get.changeThemeMode(_loadThemeData() ? ThemeMode.light : ThemeMode.dark);
    _saveTheme(!_loadThemeData());
  }
}
