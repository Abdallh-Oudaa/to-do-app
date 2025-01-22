import 'package:flutter/material.dart';

class MyTheme {
  static Color sacendryColor = const Color(0xffFFFFFF);
  static Color appBarBackground = const Color(0xff5D9CEC);
  static Color primaryColor = const Color(0xff5D9CEC);
  static Color greenColor = const Color(0xff61E757);
  static Color blackColor = Colors.black;

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor:const Color(0xffDFECDB),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff141922),
          primary: primaryColor,

          secondary: sacendryColor,
        primaryContainer: Colors.black,),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        bodyMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
  static Color sacendryColorDark = const Color(0xff141922);
  static Color appBarBackgroundDark = const Color(0xff5D9CEC);
  static Color primaryColorDark = const Color(0xff060E1E);

  static ThemeData darkTheme = ThemeData(

      scaffoldBackgroundColor: const Color(0xff060E1E),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff141922),
          primary: primaryColorDark,
          secondary: sacendryColorDark,
      primaryContainer: Colors.white,),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        bodyMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        headlineLarge: TextStyle(
            color: Color(0xff060E1E),
            fontSize: 22,
            fontWeight: FontWeight.w700),
      ),
      appBarTheme: AppBarTheme(backgroundColor: appBarBackground),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: primaryColor,
          unselectedItemColor: const Color(0xff848486)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff5D9CEC),
        iconSize: 30,
        elevation: 0,
        shape:
            StadiumBorder(side: BorderSide(width: 3, color: Color(0xff141922))),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Color(0xff141922),
        shape: CircularNotchedRectangle(),
      ));
}
