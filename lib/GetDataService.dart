import 'package:firebase_database/firebase_database.dart';

import 'modal/Prodotto.dart';

class GetDataService {
  DatabaseReference dbRef;
  Prodotto result;

  GetDataService();

  Future<Prodotto> getProdotti(String codice) async {
    dbRef = (await FirebaseDatabase.instance
        .reference()
        .child("Prodotti/" + codice));

    dbRef.once().then((DataSnapshot snapshot) {
      try {
        result = Prodotto(snapshot.value["nome"], snapshot.value["categoria"]);
        print("FIREBASE: " + result.toString());
        return result;
      } on NoSuchMethodError catch (e) {
        return null;
      }
    });
  }
}