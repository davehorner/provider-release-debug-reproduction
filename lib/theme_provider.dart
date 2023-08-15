import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  bool _animated = false;
  ThemeMode get mode => _mode;
  bool get animated => _animated;

  ThemeProvider() {
    print("THEMEPROVIDER!!!");
    /*StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'system';
      _animated = false;
      if (themeMode == 'light') {
        _mode = ThemeMode.light;
      } else if (themeMode == 'dark') {
        _mode = ThemeMode.dark;
      } else if (themeMode == 'animated') {
        _mode = ThemeMode.dark;
        _animated = true;
      } else {
        _mode = ThemeMode.system;
      }*/
    _mode = ThemeMode.system;
    _animated = false;
    print("THEMEPROVIDER!!! ${_mode}");
    // notifyListeners();
    //});
    print("THEMEPROVIDER!!! EXIT CONSTRUCTOR");
  }

  void setSystem() {
    _mode = ThemeMode.system;
    _animated = false;
    //StorageManager.saveData('themeMode', 'system');
    notifyListeners();
  }

  void setLight() {
    _mode = ThemeMode.light;
    _animated = false;
    //StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  void setAnimated() {
    _mode = ThemeMode.system;
    _animated = true;
    //StorageManager.saveData('themeMode', 'animated');
    notifyListeners();
  }

  void setDark() {
    _mode = ThemeMode.dark;
    _animated = false;
    //StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }
}
