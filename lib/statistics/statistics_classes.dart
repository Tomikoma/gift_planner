import 'package:flutter/material.dart';
import 'package:gift_planner/db/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class TopThreeSumAvg {
  final int id;
  final String name;
  final int sum;
  final int avg;

  TopThreeSumAvg({@required this.id,@required this.name, @required this.sum, @required this.avg});

  static Future<List<TopThreeSumAvg>> get dataList async{
    final SQL sql = SQL();
    final Database db = await sql.database;
  

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT persons.id, persons.name, sum(gifts.price) as ossz, avg(gifts.price) as atlag
    FROM persons 
    INNER JOIN gifts on persons.id = gifts.person_id
    GROUP BY persons.id ORDER BY ossz desc LIMIT 3''');

      return List.generate(maps.length, (i) {
      return TopThreeSumAvg(
          id: maps[i]['id'],
          name: maps[i]['name'],
          sum: maps[i]['ossz'],
          avg: (maps[i]['atlag'] as double).round());
    });
  }

}