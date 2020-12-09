import 'package:firebase_database/firebase_database.dart';
import 'package:smart_cupboard/modal/Dispensa.dart';
import 'package:sqflite/sqflite.dart';
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
}
