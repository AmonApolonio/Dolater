/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/material.dart';
import 'package:dolater/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  int themeNumber;
  ThemeData _themeData;
  String _image = "images/background1.jpg";

  ThemeNotifier(this.themeNumber);

//function to get the theme data
  getTheme(){
    _themeData = themes[themeNumber];

    return _themeData;

  }

//function to get the theme background
  getImageTheme(){
    _image = "images/background$themeNumber.jpg";

    return _image;
  }

//function to get a color from a specific theme
  getSpecificPrimaryColor(int index){
    return themes[index].primaryColor;
  }

//function to set a theme
  setTheme(value) async {
    themeNumber = value;
    _themeData = themes[value];
    _image = "images/background$value.jpg";

    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('Theme', value);

    notifyListeners();
  }


}
