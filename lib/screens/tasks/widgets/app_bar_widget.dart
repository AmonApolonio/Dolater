/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarUI extends StatefulWidget {
  final AnimationController animationController;
  final Animation<double> topBarAnimation;
  final double topBarOpacity;
  final toDoController = TextEditingController();

  final Function onSubmitted;

  AppBarUI({
    @required this.animationController,
    @required this.topBarAnimation,
    @required this.topBarOpacity,
    @required this.onSubmitted,
  });

  @override
  _AppBarUIState createState() => _AppBarUIState();
}

class _AppBarUIState extends State<AppBarUI> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
//code to control the app bar animation
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: widget.topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - widget.topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(widget.topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4 * widget.topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 16 - 8.0 * widget.topBarOpacity,
                              bottom: 12 - 8.0 * widget.topBarOpacity),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * widget.topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: Colors.black87,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Adicionar Tarefa",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22 + 6 - 6 * widget.topBarOpacity,
                                      letterSpacing: 1.2,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  controller: widget.toDoController,
                                  onEditingComplete: (){
                                    widget.onSubmitted(controller: widget.toDoController);
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: IconButton(
                                  icon: Icon(Icons.add_circle),
                                  iconSize: 40,
                                  color: Theme.of(context).primaryColor,
                                  onPressed: (){
                                    widget.onSubmitted(controller: widget.toDoController);
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                  },
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

}
