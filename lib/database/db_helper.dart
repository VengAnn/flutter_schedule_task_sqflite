import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      // ignore: no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          // ignore: avoid_print
          print("creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, "
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //inset to sqflite
  static Future<int> dbInsert(Task? task) async {
    debugPrint("insert function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  // return all field in table
  static Future<List<Map<String, dynamic>>> query() async {
    debugPrint("query function called");
    return await _db!.query(_tableName);
  }

  //delete
  static delete(Task? task) async {
    await _db!.delete(_tableName, where: 'id=?', whereArgs: [task!.id]);
  }

  // update table name tasks work with controller
  static update(int id) async {
    // Update field isCompleted from 0 to 1 (completed) for a specific task ID
    await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
  ''', [1, id]);
  }
}
