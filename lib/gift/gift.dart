import 'package:flutter/material.dart';
import 'package:gift_planner/db/sql.dart';
import 'package:sqflite/sqflite.dart';

class Gift {
  int id;
  String name;
  int price;
  int personId;

  Gift(
      {@required this.name,
      @required this.price,
      @required this.personId,
      this.id});

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'person_id': personId};
  }

  static Future<int> insertGift(Gift gift) async {
    final sql = SQL();
    final Database db = await sql.database;
    int giftId = await db.insert('gifts', gift.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return giftId;
  }

  static Future<void> removeGift(int giftId) async {
    final sql = SQL();
    final Database db = await sql.database;
    print(giftId);
    await db.delete('gifts', where: 'id = ?', whereArgs: [giftId]);
  }

  static Future<List<Gift>> gifts(int personId) async {
    final sql = SQL();
    final Database db = await sql.database;

    final List<Map<String, dynamic>> maps =
        await db.query('gifts', where: 'person_id = ? ', whereArgs: [personId]);

    return List.generate(maps.length, (i) {
      print(maps.toString());
      return Gift(
          name: maps[i]['name'],
          price: maps[i]['price'],
          id: maps[i]['id'],
          personId: maps[i]['person_id']);
    });
  }
}
