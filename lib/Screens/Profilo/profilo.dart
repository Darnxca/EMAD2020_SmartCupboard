
import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/HomePage/Components/MainDrawer.dart';

import 'components/body.dart';

class Profilo extends StatelessWidget {
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Profilo'),
        ),
        drawer: MainDrawer(), //menu laterale
        body: Body(),
      ),
    );
  }
}
