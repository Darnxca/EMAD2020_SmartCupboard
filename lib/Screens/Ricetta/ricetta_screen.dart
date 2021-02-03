import 'package:flutter/material.dart';
import 'package:smart_cupboard/modal/Ricetta.dart';

class Ricetta_Screen extends StatelessWidget {
  @override
  Ricetta ricetta;

  Ricetta_Screen({Key key, @required this.ricetta}) : super(key: key);

  Widget build(BuildContext context) {
    print("Ricetta");
    print(ricetta.toString());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            ///First show the image in background
            Hero(
              child: Container(
                height: size.height * 0.55,
                child: Image.network(
                  ricetta.urlImg,
                  fit: BoxFit.fill,
                ),
              ),
              tag: "image",
            ),

            ///Container for more content
            DraggableScrollableSheet(
              maxChildSize: 1,
              initialChildSize: 0.6,
              minChildSize: 0.6,
              builder: (context, controller) {
                return SingleChildScrollView(
                  controller: controller,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ricetta.nomeRicetta,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Difficoltà: " + ricetta.difficolta,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        ///Container for food information

                        Text(
                          "Ingredienti",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),

                        new Row(children: <Widget>[
                          Expanded(
                              child: SizedBox(
                            height: 150,
                            child: new ListView.builder(
                                itemCount: ricetta.ingredienti.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(Icons.arrow_right),
                                    title: Text(
                                      ricetta.ingredienti[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: null,
                                  );
                                }),
                          )),
                        ]),

                        SizedBox(
                          height: 24,
                        ),

                        Text(
                          "Preparazione",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 4,
                        ),

                        Text(
                          ricetta.procedimento,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
