/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dolater/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dolater/models/task_model.dart' as Model;
import 'package:scoped_model/scoped_model.dart';

class TodayTile extends StatelessWidget {
  final int index;
  final Model.Todo today;
  final Function markTodayAsLater;
  final Function deleteToday;
  final Function markAsDone;
  final Function markAsNotDone;
  final Animation<double> checkGrownAnimation;

  TodayTile({
    @required this.index,
    @required this.today,
    @required this.markTodayAsLater,
    @required this.deleteToday,
    @required this.markAsDone,
    @required this.markAsNotDone,
    @required this.checkGrownAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(today.id.toString()),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey[100], width: 1),
            bottom: BorderSide(color: Colors.grey[100], width: 1),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              child: GestureDetector(
                onTap: () => today.isDone == 0
                    ? {
                        if (ScopedModel.of<UserModel>(context).checkingState ==
                            0)
                          {
                            markAsDone(todo: today),
                            ScopedModel.of<UserModel>(context).whichOneAnimate =
                                index
                          }
                      }
                    : {
                        if (ScopedModel.of<UserModel>(context).checkingState ==
                            0)
                          {
                            markAsNotDone(todo: today),
                            ScopedModel.of<UserModel>(context).whichOneAnimate =
                                index
                          }
                      },
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      child: AnimatedBuilder(
                        animation: checkGrownAnimation,
                        child: Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        builder: (context, child) {
                          int checkingState =
                              ScopedModel.of<UserModel>(context).checkingState;
                          double animationState =
                              checkingState * checkGrownAnimation.value;

                          double idleState =
                              today.isDone == 0 || today.isDone == null
                                  ? 0.0
                                  : 1.0;

                          return Transform.scale(
                            scale: ScopedModel.of<UserModel>(context)
                                        .whichOneAnimate ==
                                    index
                                ? idleState + animationState
                                : idleState,
                            child: child,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 260,
                  child: AutoSizeText(
                    today.title,
                    maxLines: 3,
                    minFontSize: 15,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      background: Container(
        color: Theme.of(context).primaryColor,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          if (today.isDone == 1) {
            markAsNotDone(todo: today);
          }
          markTodayAsLater(
            todo: today,
          );
        } else if (direction == DismissDirection.endToStart) {
          deleteToday(
            todo: today,
          );
        }
      },
    );
  }
}