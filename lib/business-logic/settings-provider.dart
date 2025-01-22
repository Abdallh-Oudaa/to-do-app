
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{
  ThemeMode? currentTheme=ThemeMode.light;
  changeTheme(ThemeMode newTheme){
    if(newTheme==currentTheme)return;
    currentTheme=newTheme;
    notifyListeners();
  }
  bool isDarkEnalbed(){
    return currentTheme==ThemeMode.dark;
  }
}