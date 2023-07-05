import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/task_models.dart';

String path = "todo.db";
int? version = 2;
String tableName = "tasks";

class SQLHelper {
  //creating database table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE tasks (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
title STRING, 
note STRING,
date STRING, 
startTime STRING, 
endTime STRING, 
reminder STRING, 
reapert STRING,
color INTEGER,
isComplited INTEGER, 
createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)
""");
  }

  //create the database
  static Future<sql.Database> db() async {
    return sql.openDatabase("todo.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      debugPrint("...creating the todo table......");
      await createTables(database);
    });
  }

  //insert task to the Databases
  static Future<int> createTask(Task task) async {
    debugPrint("createTask Methods calls");
    final db = await SQLHelper.db();
    return await db.insert("tasks", task.toJson());
  }

  //get data from database
  static Future<List<Map<String, dynamic>>> getItems() async {
    debugPrint("Queery Methods calls");
    final db = await SQLHelper.db();
    return db.query("tasks");
  }

  // //get data by id
  // static Future<List<Map<String, dynamic>>> getItem(int id) async {
  //   final db = await SQLHelper.db();
  //   return db.query("items", where: "id = ?", whereArgs: [id], limit: 1);
  // }

  // static Future<int> updateItems(
  //     int id, String title, String description) async {
  //   final db = await SQLHelper.db();
  //   final data = {
  //     'title': title,
  //     'description': description,
  //     'createdAt': DateTime.now.toString()
  //   };

  //   final result = await db.update(
  //     'items',
  //     data,
  //     where: "id = ?",
  //     whereArgs: [id],
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //   return result;
  // }

  // //delete by id
  // static Future<void> deleteItems(int id) async {
  //   final db = await SQLHelper.db();

  //   try {
  //     await db.delete(
  //       'items',
  //       where: 'id = ?',
  //       whereArgs: [id],
  //     );
  //   } catch (e) {
  //     print("something went Wrong when delete items $e");
  //   }
  // }
}
