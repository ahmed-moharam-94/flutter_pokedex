import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController with ChangeNotifier {
  late ThemeData _themeData;
  // create an instance of sharedPreferences
  late  SharedPreferences prefs;

  ThemeData dark = ThemeData.dark().copyWith();

  ThemeData light = ThemeData.light().copyWith();

  ThemeController(bool darkThemeOn) {
    _themeData = darkThemeOn ? dark : light;
  }

  ThemeData get themeData => _themeData;

  Future<void> toggleTheme() async {
    prefs = await SharedPreferences.getInstance();
    // toggle theme if it's dark make it light and vice versa
    if (themeData == ThemeData.dark()) {
      await prefs.setBool('isDark', false);
      _themeData = light;
    } else {
      await prefs.setBool('isDark', true);
      _themeData = dark;
    }
    notifyListeners();
  }


}
