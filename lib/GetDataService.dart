import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cupboard/modal/Dispensa.dart';

import 'UserPreferences.dart';
import 'modal/Prodotto.dart';

class GetDataService {
  DatabaseReference dbRef;
  Prodotto result;
  Dispensa dispensa;
  String dataSharedPreferences;
  SharedPreferences prefs;

  GetDataService(){
    getShared();
  }

   getShared() async {
    //await UserPreferences().init();
   // dataSharedPreferences = UserPreferences().data;
    prefs = await SharedPreferences.getInstance();

    dataSharedPreferences = (prefs.getString('counter') ?? "");
    print('Pressed '+dataSharedPreferences+ ' times.');

    if(dataSharedPreferences.compareTo("")==0){
      print("ciao2");
      dispensa = Dispensa(new List<Prodotto>());
    }else{
      print("ciao");
      dispensa = Dispensa.fromJson(jsonDecode(dataSharedPreferences));
    }
  }

  Future getProdotti(String codice) async {
    dbRef = (await FirebaseDatabase.instance
        .reference()
        .child("Prodotti/" + codice));

    dbRef.once().then((DataSnapshot snapshot) {
      try {
        result = Prodotto(snapshot.value["nome"], snapshot.value["categoria"]);
        print("FIREBASE: " + result.toString());
        dispensa.addProdotto(result);
          print("PRODOTTTOOOOOOO: " + result.toString());
        dataSharedPreferences = dataSharedPreferences + jsonEncode(dispensa);
          print("SHARED " + dataSharedPreferences);

      } on NoSuchMethodError catch (e) {
        print("Prodotto non trovato");

      }
    });
  }
}
