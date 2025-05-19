import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Database/SharedPreferences/shared_preferences.dart';
import 'AppColors.dart';


class Mythemes extends ChangeNotifier {
  String currentTheme = 'system';
  ThemeData? _selectedTheme ;
  Typography? defaultTypography;
  SharedPreferences? prefs;

  ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black12,

  );


  ThemeData light = ThemeData.light().copyWith(

    scaffoldBackgroundColor: AppColors.background_color,

  );

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  changeTheme(String theme) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    await _prefs.setString('theme', theme);

    currentTheme = theme;
    notifyListeners();
  }

  ThemeData? getTheme() => _selectedTheme;
  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    currentTheme = _prefs.getString('theme') ?? 'system';
    notifyListeners();
  }
}



class ThemeService{
  SharedPreferences? prefs;
ThemeMode getThemeMode(){
  return isSavedDarkMode()?ThemeMode.dark:ThemeMode.light;
}
bool isSavedDarkMode(){
  return SharedPreferencesController().DarkTheme==true?true:false;
}

  }


