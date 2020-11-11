import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/LaMiaDIspensa/MyDispensaScreen.dart';

import '../../../constants.dart';

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryWidtht =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  width: categoryWidtht,
                  margin: EdgeInsets.only(right: 20),
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/farine_e_derivati.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Farine e derivati",
                          style: TextStyle(
                              fontSize: 18,
                              color: Black,
                              backgroundColor: Colors.grey[350],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyDispensaScreen();
                      },
                    ),
                  );
                },
              ),
              Container(
                width: categoryWidtht,
                margin: EdgeInsets.only(right: 20),
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/carne.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Carni",
                        style: TextStyle(
                            fontSize: 18,
                            color: Black,
                            backgroundColor: Colors.grey[350],
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: categoryWidtht,
                margin: EdgeInsets.only(right: 20),
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/verdure.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Verdure",
                        style: TextStyle(
                            fontSize: 18,
                            color: Black,
                            backgroundColor: Colors.grey[350],
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
