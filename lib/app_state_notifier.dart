import 'package:flutter/material.dart';
import 'package:newsapp/models/article2model.dart';
import 'package:shared_preferences/shared_preferences.dart';




class AppStateNotifier extends ChangeNotifier {
  //Bookmarks Provider
  List _bookMarks =<Map> [];
  List get bookMarks => _bookMarks;
  bool _isDarkMode = false;

  void toggleBookmark (Map<String, dynamic> bookmark){
    final isExist = _bookMarks.contains(bookmark);
    if(isExist){
      _bookMarks.remove(bookmark);
    }
    else{
      _bookMarks.add(bookmark);
    }
    notifyListeners();
  }
  bool isExist(Map<String, dynamic> bookmark){
    final isExist = _bookMarks.contains(bookmark);
    return isExist;
  }
  void clearBookmark(){
    _bookMarks = [];
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;

  //theme provider
  // Future<bool> get getThemeMode async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _isDarkMode = await prefs.getBool('isDarkMode')!;
  //   return Future.value(_isDarkMode);
  // } 
  
    
 
  void updateTheme(bool isDarkMode) async{ 
    
SharedPreferences prefs = await SharedPreferences.getInstance();
    
    this._isDarkMode = isDarkMode;
    await prefs.setBool('isDarkMode', isDarkMode); 
    
    

   
    notifyListeners();
  }
  
  
 
}




      
        
         
