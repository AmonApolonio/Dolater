/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/material.dart';
import 'package:dolater/models/user_model.dart';
import 'package:dolater/screens/home/home_screen.dart';
import 'package:dolater/screens/login/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';


class InitialScreen extends StatefulWidget {

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  @override
  Widget build(BuildContext context)  {
//code to go to the Login Screen or to the Home Screen based on whether the user is logged in or not
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        if (model.isLoggedIn()){
          return HomeScreen();
        }else{
          return LoginScreen();
        }
      }
    );
  }
}
