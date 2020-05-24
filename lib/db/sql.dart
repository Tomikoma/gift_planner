import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class SQL {
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await openDatabase(
      join(
        await getDatabasesPath(),
        'gift_planner.db',
      ),
      version: 4,
      onCreate: (db, version) async {


        await db.execute('''
        CREATE TABLE persons(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          birth TEXT
        );
        ''');

        await db.execute('''
        CREATE TABLE gifts(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          price INTEGER,
          person_id INTEGER,
          FOREIGN KEY (person_id) REFERENCES persons(id) ON DELETE CASCADE
        );
        ''');
      },
    );
    return _database;
  }
}
