
import 'package:flutter/material.dart';

class MyTheme {
  static Color sacendryColor = const Color(0xffDFECDB);
  static Color appBarBackground = const Color(0xff5D9CEC);
  static Color primaryColor = const Color(0xff5D9CEC);

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: sacendryColor,

      textTheme: const TextTheme(

        titleLarge: TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.bold) ,
        bodyLarge: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black),
        bodyMedium: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
        headlineLarge: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 22,
            fontWeight: FontWeight.w700),
      ),
      appBarTheme: AppBarTheme(backgroundColor: appBarBackground),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: primaryColor,
          unselectedItemColor: const Color(0xff848486)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        iconSize: 30,
        elevation: 0,
        shape: const StadiumBorder(
            side: BorderSide(width: 3, color: Colors.white)),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
      ));
  ThemeData darkTheme = ThemeData();
}
