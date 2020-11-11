import 'package:flutter/material.dart';
import 'package:smart_cupboard/components/text_field_container.dart';

import '../constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: Black,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Black,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Black,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
