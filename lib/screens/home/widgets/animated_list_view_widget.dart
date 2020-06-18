/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:dolater/models/task_db_wrapper.dart';
import 'package:dolater/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:dolater/screens/home/widgets/add_task_widget.dart';
import 'package:dolater/screens/home/widgets/today_tile_widget.dart';
import 'package:dolater/models/task_model.dart' as Model;
import 'package:scoped_model/scoped_model.dart';

class AnimatedListView extends StatefulWidget {
  final Animation<double> checkGrownAnimation;

  AnimatedListView({@required this.checkGrownAnimation,});

  @override
  _AnimatedListViewState createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {

  List<Model.Todo> todays;
  int tasksdoneMem;

  @override
  void initState() {
    getTodays();
    loadMem();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ScopedModel.of<UserModel>(context).totalTasks = todays != null ? todays.length : 0;

    getTodays();

//code to order the tasks based on whether the task is done or not
    while(1==1){
      if(todays != null){
        todays.sort((a, b){
          if(a.isDone == 1 && b.isDone != 1)
            return 1;
          else if(a.isDone == 1 && b.isDone == 1)
            return -1;
          else
            return 0;
        });
      }
      return Column(
        children: <Widget>[
          AddTaskButtom(),
          if(todays == null )
            Container(
              height: 10,
            ),
          if(todays != null)
            for(int i = 0; i < todays.length; ++i)
              TodayTile(
                index: i,
                today: todays[i],
                markTodayAsLater: markTodayAsLater,
                deleteToday: deleteToday,
                markAsDone: markAsDone,
                markAsNotDone: markAsNotDone,
                checkGrownAnimation: widget.checkGrownAnimation,
              ),
        ],
      );
    }

  }

//function request the user model to get the number of tasks alredy done
  void loadMem() async{
    ScopedModel.of<UserModel>(context).loadMem();
  }

//function to create a local temporary list, getting all tasks marked as "do today" from the database
  void getTodays() async {
    final _todays = await DBWrapper.sharedInstance.getTodays();

    setState(() {
      todays = _todays;
    });
  }

//function to request the database to mark a task as "do later"
  void markTodayAsLater({@required Model.Todo todo}) {
    DBWrapper.sharedInstance.markTodayAsLater(todo);
    getTodays();
  }

//function to request the database to delete a task
  void deleteToday({@required Model.Todo todo}) {
    DBWrapper.sharedInstance.deleteTodo(todo);
    getTodays();

  }

//function to request the database to mark a task as done and change the animation state
  void markAsDone({@required Model.Todo todo}) {
    ScopedModel.of<UserModel>(context).checkingState = 1;

    Future.delayed(const Duration(milliseconds: 600), () {
      ScopedModel.of<UserModel>(context).changeDonesCounterValue(1);
      ScopedModel.of<UserModel>(context).checkingState = 0;
      DBWrapper.sharedInstance.markAsDone(todo);
      getTodays();
    });
  }

//function to request the database to mark a task as done and change the animation state
  void markAsNotDone({@required Model.Todo todo}) {
    ScopedModel.of<UserModel>(context).checkingState = -1;

    Future.delayed(const Duration(milliseconds: 600), () {
      DBWrapper.sharedInstance.markAsNotDone(todo);
      ScopedModel.of<UserModel>(context).changeDonesCounterValue(-1);
      ScopedModel.of<UserModel>(context).checkingState = 0;
      getTodays();
    });
  }



}

