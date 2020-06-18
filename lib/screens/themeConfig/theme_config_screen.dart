/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:dolater/screens/themeConfig/widgets/theme_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeConfigScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: screenSize.width/18, right: screenSize.width/18,),
        child: ListView(
          children: <Widget>[
            for(int i = 1; i < 8; ++i)
            ThemeCard(index: i),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.grey[200],
            ),
            Center(
              child: Text(
                "Alterar Tema",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: EdgeInsets.only(left: 6),
                  icon: Icon(Icons.arrow_back_ios, color: Colors.grey[800], size: 30,),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
