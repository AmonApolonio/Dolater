/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */


import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dolater/screens/login/widgets/stagger_animation_widget.dart';
import 'package:dolater/screens/login/widgets/form_container_widget.dart';
import 'package:dolater/screens/login/widgets/theme_switch_widget.dart';
import 'package:provider/provider.dart';
import 'package:dolater/utils/theme_notifier.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController _animationController;
  FocusNode textfieldFocusNode;
  String currentAnimation =  "";

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

  
    textfieldFocusNode = FocusNode();
    textfieldFocusNode.addListener(onTextfieldFocusChange);
  }

  Color onTextfieldFocusChange() {
    return textfieldFocusNode != null
        ? textfieldFocusNode.hasFocus
            ? Theme.of(context).primaryColor
            : Colors.grey[400]
        : Colors.grey[400];
  }

  @override
  void dispose() {
    _animationController.dispose();
    textfieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(themeNotifier.getImageTheme()),
            fit: BoxFit.cover,
          )),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: 350,
                        height: 270,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  currentAnimation = "idle3";
                                  Future.delayed(const Duration(seconds: 1), (){
                                    currentAnimation = "idle5";
                                  });
                                }),
                                child: Container(
                                  width: 250,
                                  height: 250,
                                  child: FlareActor(
                                    "animations/DoLater_Icon_Animation.flr",
                                    animation: currentAnimation,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                             top: 24,
                            ),
                            Positioned(
                              child: Container(
                                width: 150,
                                height: 150,
                                child: Image.asset(
                                  "images/border_only_dolater_icon${Provider.of<ThemeNotifier>(context).themeNumber}.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              top: 70,
                              left: 107,
                            ),
                          ],
                        ),
                      ),
                      
                      FormContainer(
                        textfieldFocusNode: textfieldFocusNode,
                        onFocusedColor: onTextfieldFocusChange(),
                      ),
                    ],
                  ),
                  StaggerAnimation(
                    controller: _animationController.view,
                    scaffoldKey: _scaffoldKey,
                  ),
                  ThemeSwitch(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

