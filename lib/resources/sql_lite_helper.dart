import 'dart:async';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  //creating database table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
title TEXT,
description TEXT,
createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)
""");
  }

  //create the database

  static Future<sql.Database> db() async {
    return sql.openDatabase("bibek.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      print("...creating the table......");
      await createTables(database);
    });
  }

  //insert items create items
  static Future<int> createItems(String title, String description) async {
    final db = await SQLHelper.db();
    final data = {'title': title, 'description': description};

    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  //get data from database
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query("items", orderBy: "id");
  }

  //get data by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query("items", where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItems(
      int id, String title, String description) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': description,
      'createdAt': DateTime.now.toString()
    };

    final result = await db.update(
      'items',
      data,
      where: "id = ?",
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  //delete by id
  static Future<void> deleteItems(int id) async {
    final db = await SQLHelper.db();

    try {
      await db.delete(
        'items',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("something went Wrong when delete items $e");
    }
  }
}
