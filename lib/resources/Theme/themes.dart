import 'package:flutter/material.dart';
import 'package:sports_application/resources/Colors/colors.dart';

class Themes {

  static final ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: ExternalColors.offwhite,
    primaryColor: ExternalColors.darkblue,
    // textTheme:TextTheme(titleLarge: TextStyle(color: ExternalColors.offwhite,fontSize: 60, fontFamily: 'Poppins', ),
    // // bodyLarge:TextStyle(color: ExternalColors.offwhite,fontSize: 20, fontFamily: 'Poppins', decorationColor: Colors.grey, backgroundColor: ExternalColors.lightgreen)
    // ),
    colorScheme:ColorScheme(
    primary: ExternalColors.darkblue,
    secondary: ExternalColors.lightgreen, // Sets the darker variant of the secondary color
    surface: Colors.green, // Sets the surface color (background color)
    background: ExternalColors.offwhite, // Sets the background color
    error: Colors.red, // Sets the error color
    onPrimary: Colors.white, // Sets the color for text and icons on primary color
    onSecondary: Colors.white, // Sets the color for text and icons on secondary color
    onSurface: Colors.black, // Sets the color for text and icons on surface color
    onBackground: Colors.black, // Sets the color for text and icons on background color
    onError: Colors.white, // Sets the color for text and icons on error color
    brightness: Brightness.light, // Sets the brightness of the color scheme
  ),
    fontFamily: 'Poppins'
  );
  static final ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: Colors.black38,
    primaryColor: ExternalColors.darkblue,
    textTheme:TextTheme(titleLarge: TextStyle(color: ExternalColors.darkblue,fontSize: 60, fontFamily: 'Poppins'),
    bodyLarge:TextStyle(color: ExternalColors.darkblue, fontFamily: 'Poppins')
    ),
  //    colorScheme:ColorScheme(
  //   primary: ExternalColors.darkblue,
  //   secondary: ExternalColors.lightgreen, // Sets the darker variant of the secondary color
  //   surface: Colors.white, // Sets the surface color (background color)
  //   background: ExternalColors.offwhite, // Sets the background color
  //   error: Colors.red, // Sets the error color
  //   onPrimary: Colors.white, // Sets the color for text and icons on primary color
  //   onSecondary: Colors.white, // Sets the color for text and icons on secondary color
  //   onSurface: Colors.black, // Sets the color for text and icons on surface color
  //   onBackground: Colors.black, // Sets the color for text and icons on background color
  //   onError: Colors.white, // Sets the color for text and icons on error color
  //   brightness: Brightness.light, // Sets the brightness of the color scheme
  // ),
    fontFamily: 'Poppins'
  );
  
}