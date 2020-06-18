/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends Model{

  String username = "";
  String dbusername = "";

  bool isLogged;
  bool isQuitting = false;

  int checkingState = 0;

  int totalTasks = 0;
  int tasksDone = 0;

  int whichOneAnimate;

//function to save the username
  signUp(String controller) {
    username = controller;

    notifyListeners();
  }


//function to save the username on the prefs
  saveData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userKey", username);

  }

//function to get the username from the prefs
  loadData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dbusername = prefs.getString('userKey');

    notifyListeners();
  }

//function to get the number of tasks alredy done on the prefs
  loadMem() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tasksDone = prefs.getInt('donesMem/$dbusername') != null ? prefs.getInt('donesMem/$dbusername') : 0;
  }

//function to remove user's prefs data
  removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userKey');

    dbusername = "";
    username = "";
    totalTasks = 0;
    tasksDone = 0;

    notifyListeners();
  }


//function to check if the user is logged
  bool isLoggedIn() {
    loadData();
   if(dbusername == null){
      dbusername = "";
    }
    if(dbusername.isNotEmpty){
      isLogged = true;
    } else {
      isLogged = false;
    }
    return isLogged;
  }

//function to call quitting state
  quitRequest(quitRequest){
    isQuitting = quitRequest;
    notifyListeners();
  }

//function to change the number of tasks dones
  changeDonesCounterValue(int value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tasksDone += value;
    prefs.setInt("donesMem/$dbusername", tasksDone);
  }


//function to change the number of tasks dones to zero
  removeAllDones() async{
    tasksDone = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("donesMem/$dbusername", 0);
  }


}
