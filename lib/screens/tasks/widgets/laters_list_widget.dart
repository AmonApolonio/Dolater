/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:dolater/models/task_db_wrapper.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:dolater/models/task_model.dart' as Model;

class TaskList extends StatefulWidget {
  final ScrollController scrollController;
  List<Model.Todo> laters;

  TaskList({
    @required this.scrollController,
    @required this.laters,
  });

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
//code to order the tasks by index
    if (widget.laters != null) {
      widget.laters.sort((a, b) {
        if (a.index > b.index)
          return 1;
        else if (a.index == b.index)
          return -1;
        else
          return 0;
      });
    }
    return widget.laters != null
        ? ReorderableListView(
            scrollController: widget.scrollController,
            onReorder: _onReorder,
            scrollDirection: Axis.vertical,
            children: getListItems()
            )
        : Container();
  }

  List<Container> getListItems() => widget.laters
      .asMap()
      .map(
          (index, later) => MapEntry(index, buildTenableListTile(later, index)))
      .values
      .toList();

  Container buildTenableListTile(Model.Todo later, int index) => index == 0
      ? Container(
          key: ValueKey(later.id),
          height: 110,
          color: Colors.transparent,
        )
      : Container(
          height: 75,
          margin: EdgeInsets.only(
            top: 2,
            bottom: 2,
          ),
          key: ValueKey(later.id),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Dismissible(
            key: ValueKey(later.id),
            child: ListTile(
                contentPadding: EdgeInsets.only(top: 7, left: 5, right: 5),
                key: ValueKey(later.id),
                title: Text(later.title),
                leading: Container(
                  width: 50,
                  height: 100,
                  child: FlareActor(
                    "animations/Arrow_Swipe_Animation.flr",
                    animation: "arrow_left",
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                trailing: Container(
                  width: 50,
                  height: 100,
                  child: FlareActor(
                    "animations/Arrow_Swipe_Animation.flr",
                    animation: "arrow_right",
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    color: Theme.of(context).primaryColorDark,
                  ),
                )),
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment(-0.9, 0.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            secondaryBackground: Container(
              color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment(0.9, 0.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                setState(() {
                  widget.laters.removeAt(index);
                });
                deleteTask(todo: later);
              } else if (direction == DismissDirection.endToStart) {
                setState(() {
                  widget.laters.removeAt(index);
                });
                markLaterAsToday(todo: later);
              }
            },
          ),
        );

//function to change task index
  void _onReorder(int oldIndex, int newIndex) {
    Model.Todo stationaryLater = widget.laters[newIndex];
    Model.Todo movingLater = widget.laters[oldIndex];
    int position1 = stationaryLater.index;
    int position2 = movingLater.index;

    movingLater.index = position1;
    stationaryLater.index = position2;

    setState(() {
      widget.laters[newIndex] = movingLater;
      widget.laters[oldIndex] = stationaryLater;
    });

    uptadePosition(todo: movingLater);
    uptadePosition(todo: stationaryLater);
  }

//function to request the database to mark a task as "do today"
  void markLaterAsToday({@required Model.Todo todo}) {
    DBWrapper.sharedInstance.markLaterAsToday(todo);
    getLaters();
  }

//function to request the database to delete a task
  void deleteTask({@required Model.Todo todo}) {
    DBWrapper.sharedInstance.deleteTodo(todo);
    getLaters();
  }

//function to request the database to uptade task index
  void uptadePosition({@required Model.Todo todo}) {
    DBWrapper.sharedInstance.uptadeIndex(todo);
  }


//function to request the database to get as tasks marked as "do later"
  void getLaters() async {
    final _laters = await DBWrapper.sharedInstance.getLaters();

    setState(() {
      widget.laters = _laters;
    });
  }
}
