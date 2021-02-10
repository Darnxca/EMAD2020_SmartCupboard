import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:smart_cupboard/GetDataService.dart';
import 'package:smart_cupboard/Prodotti.dart';
import 'package:smart_cupboard/Screens/HomePage/Components/CategoriesScroller.dart';
import 'package:smart_cupboard/Screens/HomePage/home_page.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';
import 'package:smart_cupboard/modal/ListaSpesaEntity.dart';

class ListaSpesa extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ListaSpesa> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  Future<List<Prodotti>> _getData;
  GetDataService getDataService = GetDataService();


  @override
  void initState() {
    _getData = getDataService.getListaSpesa();

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
          centerTitle: true,
          title: Text('Lista della spesa',style: TextStyle(fontSize: 25.0),),
          leading: BackButton(
            onPressed: _tornaindietro,
          ),
        ),

        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: FutureBuilder(
                      future: _getData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          print("Errore" + snapshot.error.toString());
                          return Text(snapshot.error.toString());
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              double scale = 1.0;
                              if (topContainer > 0.5) {
                                scale = index + 0.5 - topContainer;
                                if (scale < 0) {
                                  scale = 0;
                                } else if (scale > 1) {
                                  scale = 1;
                                }
                              }
                              return Opacity(
                                  opacity: scale,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..scale(scale, scale),
                                    alignment: Alignment.bottomCenter,
                                    child: Align(
                                      heightFactor: 0.7,
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          height: 70,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 30),
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
                                                right: 5.0,
                                                bottom: 5.0),
                                            child:  Table(
                                              defaultColumnWidth: FixedColumnWidth(150.0),
                                              children: [
                                                TableRow(
                                                    children: [
                                                      TableCell(child: Padding(
                                                        padding: const EdgeInsets.only(top: 10.0),
                                                        child: Text(
                                                          snapshot.data[index].name,
                                                          textAlign:
                                                          TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.visible,
                                                          softWrap: false,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.normal),
                                                        ),
                                                      ),),
                                                      TableCell(child:  IconButton(
                                                        icon: Icon(
                                                            Icons.restore_from_trash),
                                                        tooltip: "Prodotto rimosso dalla dispensa",
                                                        onPressed: () {
                                                          getDataService.removeProductFromListaSpesa(snapshot.data[index].EAN).then((value) {
                                                            Navigator.pop(context);
                                                            Navigator.push(context, MaterialPageRoute(
                                                              builder: (context) {
                                                                return ListaSpesa();
                                                                //return tempScreen();
                                                              },
                                                            ),
                                                            );
                                                          });
                                                        },
                                                      )),
                                                    ]
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ));
                            },
                          );
                        }
                        return Text("Loadind");
                      })),
              Row(children: <Widget>[
                Container(
                  width: 200,
                  margin: const EdgeInsets.only(left: 10.0),
                  child: RoundedButton(
                    text: "Rimuovi tutto",
                    press: (){
                      getDataService.removeAllFromListaSpesa().then((value) {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ListaSpesa();
                            //return tempScreen();
                          },
                        ),
                        );
                      }
                      );
                    },
                  ),
                ),

                SizedBox(width: 10),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, top: 0, right: 5, bottom: 30.0),
                        child: new IconButton(
                          icon: Icon(Icons.add_circle, size: 50),
                          onPressed: () {
                            _settingModalBottomSheet(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, top: 0, right: 5, bottom: 30.0),
                        child: new IconButton(
                          icon: Icon(Icons.share, size: 50),
                          onPressed: () {
                            _getData.then((value) {
                              String lista="Lista della spesa: \n";
                              value.forEach((element) {
                                lista+= element.name + "\n";
                              });
                              Share.share(lista + "\n Creata da SmartCupboard");
                            });

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    String nomeProdotto;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    width: 300.0,
                    child: RoundedInputField(
                      hintText: "Inserisci nome prodotto",
                      icon: null,
                      validator: (input) {
                        if (input.isEmpty()) {
                          return 'Inserisci nome prodotto';
                        } else {
                          return input;
                        }
                      },
                      onChanged: (input) {nomeProdotto = input;},
                    ),
                  ),
                  Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 75, vertical: 0),
                    width: 250.0,
                    child: RoundedButton(
                      text: "Aggiungi alla lista",
                      press: (){
                        ListaSpesaEntity d = ListaSpesaEntity(DateTime.now().millisecondsSinceEpoch.toString(), nomeProdotto);
                        getDataService.inserisciProdottoListaSpesa(d).then((value) {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ListaSpesa();
                              //return tempScreen();
                            },
                          ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  void _tornaindietro(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      ) ,
    );
  }
}
