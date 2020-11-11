import 'package:flutter/material.dart';
import 'package:smart_cupboard/components/text_field_container.dart';

import '../constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Black,
        decoration: InputDecoration(

          icon: Icon(
            icon,
            color: Black,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
