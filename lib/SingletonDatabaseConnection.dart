import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SingletonDatabaseConnection {
  // Singleton pattern
  static final SingletonDatabaseConnection _dbManager =
      new SingletonDatabaseConnection._internal();

  SingletonDatabaseConnection._internal();

  static SingletonDatabaseConnection get instance => _dbManager;

  // Members
  static Future<Database> _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = openDatabase(
      join(await getDatabasesPath(), 'dispensa_database.db'),
      onCreate: (db, version) {
        _createDb(db);
      },
      version: 1,
    );
    return _database;
  }

  static void _createDb(Database db) {
    db.execute('CREATE TABLE Dispensa(key_EAN TEXT PRIMARY KEY, nome TEXT, categoria TEXT)');
    db.execute('CREATE TABLE ListaSpesa(key_EAN TEXT PRIMARY KEY, nome TEXT)');
  }
}
