import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeKey = 'theme_mode';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _initialized = false;

  ThemeMode get themeMode => _themeMode;

  /// Load saved theme from SharedPreferences. Call before runApp.
  Future<void> loadFromPrefs() async {
    if (_initialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_themeKey);
      if (saved == 'light') {
        _themeMode = ThemeMode.light;
      } else if (saved == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.system;
      }
      _initialized = true;
    } catch (_) {
      _initialized = true;
    }
  }

  void setLightMode() {
    _themeMode = ThemeMode.light;
    _saveToPrefs('light');
    notifyListeners();
  }

  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    _saveToPrefs('dark');
    notifyListeners();
  }

  void setSystemMode() {
    _themeMode = ThemeMode.system;
    _saveToPrefs('system');
    notifyListeners();
  }

  Future<void> _saveToPrefs(String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, value);
    } catch (_) {}
  }
}
