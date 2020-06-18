/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/material.dart';
import 'package:dolater/screens/home/widgets/animated_list_view_widget.dart';
import 'package:dolater/screens/home/widgets/fade_container_widget.dart';
import 'package:dolater/screens/home/widgets/home_top_widget.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;
  final AnimationController circleGrowController;
  final Color primaryColor;

  StaggerAnimation(
    //code to set the screen animations
      {@required this.controller,
      @required this.circleGrowController,
      @required this.primaryColor})
      : containerGrow =
            CurvedAnimation(parent: controller, curve: Curves.easeOutSine),
        listSlidePosition = EdgeInsetsTween(
          begin: EdgeInsets.only(top: 0),
          end: EdgeInsets.only(top: 80),
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.325, 0.8, curve: Curves.easeOutSine))),
        fadeAnimation = ColorTween(
          begin: primaryColor.withOpacity(1.0),
          end: primaryColor.withOpacity(0.0),
        ).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInSine)),
        circleGrow = CurvedAnimation(
            parent: circleGrowController, curve: Curves.easeOutSine),
        checkGrown = CurvedAnimation(
            parent: circleGrowController, curve: Curves.decelerate);

  final Animation<double> containerGrow;
  final Animation<double> circleGrow;
  final Animation<double> checkGrown;
  final Animation<EdgeInsets> listSlidePosition;
  final Animation<Color> fadeAnimation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: screenSize.height * 0.37),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            AnimatedListView(
                checkGrownAnimation: checkGrown,
                ),
          ],
        ),
      ),
      HomeTop(
        circleGrow: circleGrow,
        containerGrow: containerGrow,
      ),
      IgnorePointer(
        child: FadeContainer(
          fadeAnimation: fadeAnimation,
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBuilder(
          animation: controller,
          builder: _buildAnimation,
        ),
      ),
    );
  }
}
