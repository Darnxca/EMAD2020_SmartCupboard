import 'package:flutter/material.dart';
import 'package:smart_cupboard/components/text_field_container.dart';

import '../constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FormFieldValidator validator;
  final TextEditingController controller;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
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
