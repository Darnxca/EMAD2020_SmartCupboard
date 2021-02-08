import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_cupboard/GetDataService.dart';
import 'package:smart_cupboard/Screens/HomePage/Components/MainDrawer.dart';
import 'package:smart_cupboard/Screens/Ricetta/ricetta_screen.dart';
import 'Components/CategoriesScroller.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  GetDataService getDataService = GetDataService();

  List<Widget> itemsData = [];


  @override
  void initState() {
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    final double categoryHeight = size.height * 0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        drawer: MainDrawer(), //menu laterale
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              const SizedBox(
                width: double.infinity,
                height: 60,
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 20, right: 0, left: 15, bottom: 10),
                  child: Text(
                    "La tua dispensa",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer ? 0 : categoryHeight,
                    child: categoriesScroller), //scroll orizzontale superiore
              ),
              const SizedBox(
                width: double.infinity,
                height: 40,
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 0, right: 0, left: 15, bottom: 10),
                  child: Text(
                    "Ricette che ti potrebbero interessare",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: getDataService.gellAllRicetteChePuoiFare(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        print("Errore" + snapshot.error.toString());
                        return Text(snapshot.error.toString());
                      } else
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data.length == 0) {
                          return Text("Ci dispiace, non ci sono ricette riproducibili con i tuoi ingredienti");
                        }
                          return snapshot.hasData
                              ? ListView.builder(
                              controller:
                              controller,
                              //serve per far nascondere la lista orizzontale sopra
                              itemCount: snapshot.data.length,
                              physics:
                              BouncingScrollPhysics(),
                              //effetto rimbalzo
                              itemBuilder: (context, index) {
                                return Align(
                                    heightFactor: 0.7,
                                    alignment: Alignment.topCenter,
                                    child: InkWell(
                                      child: Container(
                                          height: 150,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 40),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withAlpha(100),
                                                    blurRadius: 10.0),
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0,
                                                top: 15.0,
                                                bottom: 15.0),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 0.0,
                                                        top: 0.0, bottom: 0.0),
                                                    child: Image.network(
                                                        snapshot.data[index].urlImg,
                                                        height: 100,
                                                        width: 120)),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20.0),
                                                      child: Text(
                                                        snapshot.data[index].nomeRicetta,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            decoration: TextDecoration.none,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20.0),
                                                      child: Text(
                                                        "Difficoltà: "+snapshot.data[index].difficolta,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            decoration: TextDecoration.none,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Ricetta_Screen(
                                                  ricetta: snapshot
                                                      .data[index]);
                                            },
                                          ),
                                        );
                                      },
                                    ));
                              })
                        : Text("Niente da mostrare!");
                      } else {
                      return Center(
                      child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                      ),
                      ),
                      );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
