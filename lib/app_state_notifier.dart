import 'package:flutter/material.dart';
import 'package:newsapp/models/article2model.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ThemeProvider extends ChangeNotifier {
//light theme
ThemeData light = ThemeData(
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

//dark theme

ThemeData dark = ThemeData(
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

  //Theme provider
late ThemeData _selectedTheme ;

ThemeProvider({required bool isDarkMode}){
  this._selectedTheme = isDarkMode ? dark : light ;
}
void swapTheme()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(_selectedTheme == dark){
    _selectedTheme = light;
    prefs.setBool("isDarkTheme", false);
  }
  else{
    _selectedTheme = dark;
    prefs.setBool("isDarkTheme",true);
  }
  
  //_selectedTheme = _selectedTheme == dark ? light : dark;
  notifyListeners();
}

ThemeData get getTheme => _selectedTheme;



 
  
    
 
  
  
 
}




      
        
         
