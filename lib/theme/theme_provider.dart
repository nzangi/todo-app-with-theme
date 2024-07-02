import 'package:flutter/material.dart';
import 'package:notesapp/theme/theme.dart';


class ThemeProvider with ChangeNotifier{
  // initially theme is light
  ThemeData _themeData = lightMode;

  // get method to access the theme from other parts of the code
  ThemeData get themeData => _themeData;

  // get method to see if were in dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  //set method to get new mode
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  // switch the mode in dark or light mode

  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}