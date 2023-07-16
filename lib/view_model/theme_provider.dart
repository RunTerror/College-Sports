import 'package:flutter/material.dart';
import '../resources/Theme/themes.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeData _theme=Themes.lightTheme;
  ThemeData get theme=> _theme;

  void toogleTheme(){
    var islight=_theme==Themes.lightTheme;
    if(islight){
      _theme=Themes.darkTheme;
    }
    else{
      _theme=Themes.lightTheme;
    }
    notifyListeners();
  }
  
}