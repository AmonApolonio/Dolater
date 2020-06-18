/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:dolater/models/user_model.dart';
import 'package:dolater/screens/home/widgets/stagger_animation_widget.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _circleGrowController;

  @override
  void initState() {
    super.initState();

//code to hide de notification bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

//code to set the screen animations
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _circleGrowController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _circleGrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
//code to control the animations based on the state 
        if(model.isQuitting){
          _controller.reverse();
        }
        if(model.checkingState == 1 || model.checkingState == -1){
          _circleGrowController.forward();

          Future.delayed(const Duration(milliseconds: 600), () {
            _circleGrowController.reset();
          });
        }
        return StaggerAnimation(
          circleGrowController: _circleGrowController.view,
          controller: _controller.view,
          primaryColor: Theme.of(context).primaryColor,
        );
      }
    );
  }
}
