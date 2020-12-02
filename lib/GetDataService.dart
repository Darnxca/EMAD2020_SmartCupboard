import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:smart_cupboard/modal/Dispensa.dart';

import 'UserPreferences.dart';
import 'modal/Prodotto.dart';

class GetDataService {
  DatabaseReference dbRef;
  Prodotto result;
  Dispensa dispensa;
  String dataSharedPreferences;

  GetDataService(){
    getShared();
    if(UserPreferences().data != ''){
      dispensa = Dispensa.fromJson(jsonDecode(UserPreferences().data));
    }else{
      dispensa = Dispensa(new List<Prodotto>());
    }
  }

  void getShared() async {
    await UserPreferences().init();
    dataSharedPreferences = UserPreferences().data;
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
          UserPreferences().data = dataSharedPreferences + jsonEncode(dispensa);
          print("SHARED " + UserPreferences().data);

      } on NoSuchMethodError catch (e) {
        print("Prodotto non trovato");

      }
    });
  }
}
