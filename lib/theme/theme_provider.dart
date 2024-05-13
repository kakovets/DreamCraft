import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart';

class ThemeProvider with ChangeNotifier {

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    notifyListeners();
    saveTheme();
  }

  Future<ThemeData> getSavedTheme() async {
    var prefs = await SharedPreferences.getInstance();
    bool savedThemeIsLight = prefs.getBool('themeIsLight') ?? true;
    themeData = savedThemeIsLight ? lightMode : darkMode;
    return savedThemeIsLight ? lightMode : darkMode;
  }

  void saveTheme() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('themeIsLight', themeData == lightMode);
  }
}