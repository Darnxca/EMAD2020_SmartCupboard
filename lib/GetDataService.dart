import 'package:firebase_database/firebase_database.dart';
import 'package:smart_cupboard/item.dart';
import 'package:smart_cupboard/modal/Dispensa.dart';
import 'package:sqflite/sqflite.dart';
import 'Prodotti.dart';
import 'SingletonDatabaseConnection.dart';
import 'modal/DispensaEntity.dart';

class GetDataService {
  DatabaseReference dbRef;
  DispensaEntity result;
  Dispensa dispensa;
  Future<Database> database;

  GetDataService() {}

  Future getProdottiFromFirebase(String codice) async {
    dbRef = (await FirebaseDatabase.instance
        .reference()
        .child("Prodotti/" + codice));

    dbRef.once().then((DataSnapshot snapshot) {
      try {
        result = DispensaEntity(
            codice, snapshot.value["nome"], snapshot.value["categoria"]);
        print("FIREBASE: " + result.toString());

        insertProdottoDispensa(result);
      } on NoSuchMethodError catch (e) {
        print("Prodotto non trovato");
      }
    });
  }

  Future<void> insertProdottoDispensa(DispensaEntity d) async {
    final Database db = await SingletonDatabaseConnection.instance.database;

    await db.insert(
      'Dispensa',
      d.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DispensaEntity>> getDispensa() async {
    Database db = await SingletonDatabaseConnection.instance.database;

    final List<Map<String, dynamic>> maps = await db.query('Dispensa');

    return List.generate(maps.length, (i) {
      return DispensaEntity(
        maps[i]['key_EAN'],
        maps[i]['nome'],
        maps[i]['categoria'],
      );
    });
  }

  Future<List<Item>> getDispensa2() async {
    Database db = await SingletonDatabaseConnection.instance.database;

    final List<Map<String, dynamic>> categorie =
        await db.rawQuery('SELECT DISTINCT categoria FROM Dispensa');

    final List<Map<String, dynamic>> prodotti =
        await db.rawQuery('SELECT * FROM Dispensa ORDER BY categoria');


    List<Item> items=[];


    for (int i = 0; i < categorie.length; i++) {
      List<Prodotti> listProdotti = [];

      for (int j = 0; j < prodotti.length; j++) {
        if (prodotti[j]['categoria'] == categorie[i]['categoria']) {
         listProdotti.add(new Prodotti(name: prodotti[j]['nome']));
        }
      }
      items.add(new Item(
        categoryName: categorie[i]['categoria'],
        expandedValue: 'Details for Book  goes where',
        prodottiDipensa: listProdotti,
        urlImg: categorie[i]['categoria'].toLowerCase()+".png",
      ));
      print(categorie[i]['categoria'].toLowerCase().replaceAll(new RegExp(r"\s+"), "")+".png");
    }


    return items;
  }
}
