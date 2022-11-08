import 'package:flutter/material.dart';


 
 
class AppTheme {
  //
  AppTheme._();
 
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      
      secondary: Colors.red,
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      subtitle2: TextStyle(
        color: Colors.black54,
        
      ),
       headline1: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
       headline5: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
       
    ),
     drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
    ),
  );
 
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      
      iconTheme: IconThemeData(
        color: Colors.blue,
      ),
      //toolbarTextStyle: TextStyle(color: Colors.white),
     titleTextStyle: TextStyle(color: Colors.white)
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      // primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: const CardTheme(
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      subtitle1: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
        
      ),
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headline5: TextStyle(
        color: Colors.blue,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
     
    ),
    dividerTheme:const DividerThemeData(
      color:Colors.white70),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.black,
    ),
    
    ) ;
}
