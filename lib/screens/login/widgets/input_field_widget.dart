/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/material.dart';
import 'package:dolater/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final Icon icon;
  final Color inputColor;
  final FocusNode textfieldFocusNode;

  InputField({
    this.icon,
    this.hint,
    this.obscure,
    this.textfieldFocusNode,
    this.inputColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return TextFormField(
            focusNode: textfieldFocusNode,
            obscureText: obscure,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              model.signUp(value);
            },
            onEditingComplete: () => textfieldFocusNode.unfocus(),
            style: TextStyle(
              color: inputColor,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
                icon: icon,
                hintText: hint,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18
                ),
                contentPadding: EdgeInsets.only(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  left: 0,
                )),
          );
        },
      ),
    );
  }
}
