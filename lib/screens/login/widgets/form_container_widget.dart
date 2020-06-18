/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/material.dart';
import 'package:dolater/screens/login/widgets/input_field_widget.dart';

class FormContainer extends StatelessWidget {

  final FocusNode textfieldFocusNode;
  final Color onFocusedColor;

  FormContainer({this.textfieldFocusNode, this.onFocusedColor});


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      height: 52,
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      margin: EdgeInsets.only(right: 20, left: 20, bottom: screenSize.height/3, top: screenSize.height/12),
      child: InputField(
        hint: "Username",
        obscure: false,
        icon: Icon(Icons.person_outline, color: onFocusedColor, size: 33,),
        textfieldFocusNode: textfieldFocusNode,
        inputColor: onFocusedColor,
      ),
    );
  }
}
