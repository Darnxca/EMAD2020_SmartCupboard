
import 'package:flutter/material.dart';

class Ricetta_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(
                  'assets/images/pollo_alla_cacciatora.jpg',
                  fit: BoxFit.fill                  ,
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
                              "Pollo alla cacciatora",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),

                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Difficoltà: media",
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

                        SizedBox(
                          height: 4,
                        ),

                        ListTile(
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            '600gr di Pollo',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onTap: null,
                        ),

                        ListTile(
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            '2 Cipolle medi',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onTap: null,
                        ),

                        ListTile(
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            'Pomodori',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onTap: null,
                        ),

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
                          "Per preparare il pollo alla cacciatora cominciate dal taglio delle verdure. Dopo aver mondato la cipolla, sbucciate anche la carota e spuntatela, infine togliete il ciuffo dal sedano e tritate il tutto fino ad ottenere dei dadini di 2-3 mm 1. Poi passate alla pulizia del pollo. Tagliatelo in pezzi separando cosce, petto e alette 2. A questo punto avete tutto quello che vi occorre, spostatevi ai fornelli. In una casseruola mettete a scaldare un goccio d’olio, non esagerate perché la pelle del pollo rilascerà molto grasso. Accendete la fiamma e lasciate scaldare qualche istante, dopodiché versate i pezzi di pollo, cominciando sempre dal lato della pelle ",
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