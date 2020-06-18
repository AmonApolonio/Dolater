/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:dolater/utils/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeCard extends StatelessWidget {

  int index;

  ThemeCard({@required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: 320,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              image: DecorationImage(
                image: AssetImage("images/background${index}_e.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 25.0),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.radio_button_checked,
                size: 60,
                color: Provider.of<ThemeNotifier>(context).themeNumber == index
                    ? Provider.of<ThemeNotifier>(context).getSpecificPrimaryColor(index)
                    : Colors.white,
              ),
              onPressed: (){
                Provider.of<ThemeNotifier>(context, listen: false)
                    .setTheme(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
