import 'package:flutter/widgets.dart';
import 'package:gift_planner/db/sql.dart';
import 'package:gift_planner/gift/gift.dart';
import 'package:sqflite/sqlite_api.dart';

class Person {
  int id;
  String name;
  DateTime birth;
  List<Gift> gifts;

  Person({this.id, @required this.name, @required this.birth}) {
    this.gifts = [];
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'birth': birth.toString().split(" ")[0]};
  }

  static Future<int> insertPerson(Person person) async {
    final sql = SQL();
    final Database db = await sql.database;
    return db.insert('persons', person.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> removePerson(int personId) async {
    final sql = SQL();
    final Database db = await sql.database;
    await db.delete('persons', where: 'id = ? ', whereArgs: [personId]);
  }

  static Future<List<Person>> persons() async {
    final sql = SQL();
    final Database db = await sql.database;



    final List<Map<String, dynamic>> maps = await db.query('persons');
    return List.generate(maps.length, (i) {
      print(maps.toString());
      return Person(
          name: maps[i]['name'],
          birth: DateTime.parse(maps[i]['birth']),
          id: maps[i]['id']);
    });
  }

  
}
