/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:dolater/models/task_db_wrapper.dart';
import 'package:dolater/screens/tasks/widgets/app_bar_widget.dart';
import 'package:dolater/screens/tasks/widgets/laters_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:dolater/models/task_model.dart' as Model;

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  AnimationController animationController;
  Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;

  List<Model.Todo> laterList;

  @override
  void initState() {
    getLaters();

//Code to control the app bar animation    
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.reply,
            //keyboard_return /first_page /arrow_back_ios /navigate_before /reply
            color: Colors.white,
            size: 30,
          ),
        ),
        body: Stack(
          children: <Widget>[
            TaskList(
              scrollController: scrollController,
              laters: laterList,
            ),
            AppBarUI(
                animationController: animationController,
                topBarAnimation: topBarAnimation,
                topBarOpacity: topBarOpacity,
                onSubmitted: addTaskInTodo,
            ),
          ],
        ));
  }

//function to create a local temporary list, getting all tasks marked as "do later" from the database
  void getLaters() async {
    final _laters = await DBWrapper.sharedInstance.getLaters();

    setState(() {
      laterList = _laters;
    });
  }

//function to request the database to add a new task 
  void addTaskInTodo({@required TextEditingController controller}) async {
      final _laters = await DBWrapper.sharedInstance.getLaters();
      final inputText = controller.text.trim();

      if (inputText.length > 0) {
        Model.Todo todo = Model.Todo(
          title: inputText,
          index: laterList == null ? 1 : _laters.length,
          isDone: Model.TodoIsDone.notDone.index,
          status: Model.TodoStatus.later.index,
        );

        DBWrapper.sharedInstance.addTodo(todo);
        getLaters();
      } else {
        FocusScope.of(context).requestFocus(new FocusNode());
      }

      controller.text = '';
  }


}


