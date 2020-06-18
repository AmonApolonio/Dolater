/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dolater/screens/tasks/tasks_screen.dart';

class AddTaskButtom extends StatefulWidget {

  @override
  _AddTaskButtomState createState() => _AddTaskButtomState();
}

class _AddTaskButtomState extends State<AddTaskButtom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
//code to set the screen transition animation
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutSine
                )),
                child: new SlideTransition(
                  position: new Tween<Offset>(
                    begin: Offset.zero,
                    end: const Offset(1.0, 0.0),
                  ).animate(secondaryAnimation),
                  child: child,
                ),
              );
            },
            pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                ) {
              return TasksScreen();
            }),
        );
      },
      child: Container(
        color: Colors.white,
        width: 400,
        height: 80,
        margin: EdgeInsets.zero,
        child: Container(
            padding:
            EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
            width: 300,
            height: 70,
            child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(5),
                dashPattern: [3, 4],
                strokeWidth: 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 15, left: 12, bottom: 2),
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            "Adicione uma nova tarefa",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      )),
                ))),
      ),
    );
  }
}
