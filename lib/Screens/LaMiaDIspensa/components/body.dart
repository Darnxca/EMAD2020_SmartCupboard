import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cupboard/Screens/Aggiunta/aggiunta.dart';
import 'package:smart_cupboard/Screens/Login/login_screen.dart';
import 'package:smart_cupboard/Screens/Signup/signup_screen.dart';
import 'package:smart_cupboard/Screens/Welcome/components/background.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/mia_dispensa.dart';

import '../../../constants.dart';

class BodyExpansionPanel extends StatefulWidget {
  BodyExpansionPanel({Key key}) : super(key: key);

  @override
  _BodyExpansionPanelState createState() => _BodyExpansionPanelState();
}

class _BodyExpansionPanelState extends State<BodyExpansionPanel> {
  List<Item> _books = generateItems();
  String data ;

  Future<String> getShared() async{
    //await UserPreferences().init();
    // dataSharedPreferences = UserPreferences().data;
    SharedPreferences prefs = await SharedPreferences.getInstance() ;

    String dataSharedPreferences = (prefs.getString('counter') ?? "");
    print('Pressed '+dataSharedPreferences+ ' times.');

    if(dataSharedPreferences.compareTo("")==0){
      print("ciao2");
      //dispensa = Dispensa(new List<Prodotto>());
    }else {
      print("ciao");
      //dispensa = Dispensa.fromJson(jsonDecode(dataSharedPreferences));
    }

    return dataSharedPreferences;
  }

  @override
  void initState(){

    getShared().then((value) => data = value);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _books[index].isExpanded = !isExpanded;
        });
      },
      children: _books.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/" + item.urlImg),
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
                      item.categoryName,
                      style: TextStyle(
                          fontSize: 18,
                          color: Black,
                          backgroundColor: Colors.grey[350],
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
          body: new ListView.builder
                  (
                    itemCount: item.prodottiDipensa.length,
                    shrinkWrap: true, // risolve l'errore pos 12: 'child.hasSize'
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 5.0),
                        child: new Row(
                          children: <Widget>[
                            Text(
                              item.prodottiDipensa[index].name,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.add_shopping_cart),
                            Spacer(),
                            Icon(Icons.restore_from_trash),
                          ],
                        ),
                      );
                    }
                ),

          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.categoryName,
    this.isExpanded = false,
    this.prodottiDipensa,
    this.urlImg,
  });

  String expandedValue;
  String categoryName;
  bool isExpanded;
  String urlImg;
  List<Prodotti> prodottiDipensa;
}

class Prodotti {
  Prodotti({
    this.name,
  });

  String name;
}

List<Item> generateItems()  {

  List<Item> listItems = [];
  List<Prodotti> listProdotti = [];
  List<dynamic> responseList = CATEGORY_DATA;

  responseList.forEach((post) {
    List<dynamic> prod = post["prodotti"];

    listProdotti = [];

    prod.forEach((element) {
      listProdotti.add(
        new Prodotti(name: element["name"]),
      );
    });


    listItems.add(new Item(
      categoryName: post["name"],
      expandedValue: 'Details for Book  goes where',
      prodottiDipensa: listProdotti,
      urlImg: post["image"],
    ));
  });

  return listItems;
}
