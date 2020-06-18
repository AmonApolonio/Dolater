/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/material.dart';
import 'package:dolater/themes.dart';
import 'package:dolater/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {


  @override
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
              right: BorderSide(
                color: Colors.white,
                width: 2.0,
              ))),
      height: 50,
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: 50,
        child: GridView(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 1.5,
            childAspectRatio: 0.8,
          ),
          children: List.generate(themes.length, (index) {
            return GestureDetector(
              onTap: (){
                Provider.of<ThemeNotifier>(context, listen: false)
                .setTheme(index + 1);
          },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(20),
                  ),
                  color: index + 1 ==
                          Provider.of<ThemeNotifier>(context).themeNumber
                      ? Colors.white
                      : Colors.white.withOpacity(0),
                ),
                child: Container(
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: themes[index + 1].primaryColor,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
