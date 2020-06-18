/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:dolater/models/task_db_wrapper.dart';
import 'package:dolater/screens/home/widgets/circular_button_widget.dart';
import 'package:dolater/screens/themeConfig/theme_config_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dolater/models/user_model.dart';
import 'package:dolater/utils/initial_screen_notifier.dart';
import 'package:dolater/utils/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:math' as math;

class HomeTop extends StatefulWidget {
  final Animation<double> containerGrow;
  final Animation<double> circleGrow;

  HomeTop({@required this.containerGrow, @required this.circleGrow});

  @override
  _HomeTopState createState() => _HomeTopState();
}

class _HomeTopState extends State<HomeTop> with SingleTickerProviderStateMixin {
  AnimationController menuAnimationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation menuRotationAnimation;
  Animation rotationAnimation;

  @override
  void initState() {
    //code to set the screen animations
    menuAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(menuAnimationController);

    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(menuAnimationController);

    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(menuAnimationController);

    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(
            parent: menuAnimationController, curve: Curves.easeOut));
    menuRotationAnimation = Tween<double>(begin: 0.0, end: 90.0).animate(
        CurvedAnimation(
            parent: menuAnimationController, curve: Curves.easeOut));
    super.initState();
    menuAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.37,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(themeNotifier.getImageTheme()),
        fit: BoxFit.cover,
      )),
      child: Stack(
        children: <Widget>[
        //code to set the top left menu button
          ScopedModelDescendant<UserModel>(builder: (context, child, model) {
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 6, left: 6),
                  child: Stack(                    
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(90),
                            (degThreeTranslationAnimation.value * 70) + 6),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degThreeTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            color: Colors.white,
                            width: 35,
                            height: 35,
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Theme.of(context).primaryColor,
                            ),
                            onClick: () {
                              menuAnimationController.reverse();
                              model.quitRequest(true);
                              Future.delayed(const Duration(milliseconds: 1300), () {
                                model.removeData();
                              });
                              Future.delayed(const Duration(milliseconds: 1400), () {
                                model.quitRequest(false);
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => InitialScreen(),
                                ));
                              });
                            },
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(45),
                            (degTwoTranslationAnimation.value * 70) + 6),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degTwoTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            color: Colors.white,
                            width: 35,
                            height: 35,
                            icon: Icon(
                              Icons.autorenew,
                              color: Theme.of(context).primaryColor,
                            ),
                            onClick: () {
                              ScopedModel.of<UserModel>(context).removeAllDones();
                              DBWrapper.sharedInstance.deleteAllDones();
                            },
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(0),
                            (degOneTranslationAnimation.value * 70) + 6),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degOneTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            color: Colors.white,
                            width: 35,
                            height: 35,
                            icon: Icon(
                              Icons.color_lens,
                              color: Theme.of(context).primaryColor,
                            ),
                            onClick: () {
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
                                      return ThemeConfigScreen();
                                    }),
                              );
                            },
                          ),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(menuRotationAnimation.value)),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Theme.of(context).primaryColor,
                          width: 45,
                          height: 45,
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onClick: () {
                            if (menuAnimationController.isCompleted) {
                              menuAnimationController.reverse();
                            } else {
                              menuAnimationController.forward();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  width: 110,
                  height: 110,
                ),
              ],
            );
          }),
          Container(
            margin: EdgeInsets.only(right:screenSize.width/3, left: screenSize.width/3, top: screenSize.height/100, ),
            child: Column(
              children: <Widget>[
                Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 30, bottom: 25),
                      child: Text(
                        "MEU DIA",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    )),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 5),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: new Border.all(
                            width: 5,
                            color: Theme.of(context).primaryColor.withOpacity(0.7),
                          )),
                    ),
                    AnimatedBuilder(
                        animation: widget.circleGrow, builder: _buildCircleAnimation)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleAnimation(
    BuildContext context,
    Widget child,
  ) {

//code to set the circular progress indicator current radius
    if (ScopedModel.of<UserModel>(context).tasksDone < 0) {
      ScopedModel.of<UserModel>(context).tasksDone = 0;
    }
    double radiusVar = ScopedModel.of<UserModel>(context).checkingState *
        360 /
        (ScopedModel.of<UserModel>(context).totalTasks == 0
            ? 1.0
            : ScopedModel.of<UserModel>(context).totalTasks);

    double radiusRecoil = (220) * (1.0 - widget.containerGrow.value);

    double radiusMem = (ScopedModel.of<UserModel>(context).tasksDone * 360) /
            (ScopedModel.of<UserModel>(context).totalTasks == 0
                ? 1.0
                : ScopedModel.of<UserModel>(context).totalTasks) +
        5;

    double radiusChange = radiusVar * widget.circleGrow.value;

    return Container(
      child: CustomPaint(
        painter: CurvePainter(
            theme: Theme.of(context),
            colors: [
              Theme.of(context).primaryColorDark,
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark,
            ],
            angle: radiusMem + radiusChange + radiusRecoil),
        child: SizedBox(
          width: 110,
          height: 110,
        ),
      ),
    );
  }

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }
}

//code to draw the circular progress indicator
class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;
  final ThemeData theme;

  CurvePainter({this.colors, this.angle = 140, this.theme});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);

    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(270),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.white;
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(270),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(262),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended... but I used anyway XP
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(270),
        degreeToRadians(360 - (365 - angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: angle < 6
          ? [Colors.white.withOpacity(0), Colors.white.withOpacity(0)]
          : [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(-5.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
