import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/Login/components/background.dart';


class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Lista della spesa",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),


          ],
        ),
      ),
    );
  }
}
