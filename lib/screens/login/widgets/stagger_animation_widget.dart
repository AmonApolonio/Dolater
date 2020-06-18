/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/material.dart';
import 'package:dolater/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

  StaggerAnimation({this.controller,this.scaffoldKey})
      : buttonSqueeze = Tween(
          begin: 320.0,
          end: 60.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.150),
        )),
        buttonZoomOut = Tween(
          begin: 60.0,
          end: 1000.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 1, curve: Curves.bounceOut),
        ));

  final Animation<double> buttonSqueeze;
  final Animation<double> buttonZoomOut;

//code to control the transition animation
  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 100),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return InkWell(
            onTap: () {
              if(model.username.isNotEmpty){
                controller.forward();
                Future.delayed(const Duration(seconds: 2), (){
                  model.saveData();

                });
              }else {
                scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text("Insira um nome de usuário para entrar"),
                    backgroundColor: Theme.of(context).primaryColor,
                    duration: Duration(seconds: 2),
                  ),
                );
              }

            },
            onLongPress: () {
              controller.reset();
            },
            child: Hero(
              tag: "LoginFade",
              child: buttonZoomOut.value <= 60
                  ? Container(
                  width: buttonSqueeze.value,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: _buildInside(context))
                  : Container(
                width: buttonZoomOut.value,
                height: buttonZoomOut.value,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: buttonZoomOut.value < 500 ?
                    BorderRadius.all(Radius.circular(80.0)) : BorderRadius.all(Radius.circular(0.0))
                ),
              ),
            ),
          );
        },
      )
    );
  }

  Widget _buildInside(BuildContext context) {
    if (buttonSqueeze.value > 75) {
      return Text(
        "Sign In",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 1.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }

}
