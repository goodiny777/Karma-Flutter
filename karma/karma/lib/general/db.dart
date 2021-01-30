import 'dart:io';

import 'package:karma/models/deed.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "Deeds.db";
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Deed ("
          "id INTEGER PRIMARY KEY,"
          "description TEXT,"
          "type BIT,"
          "value INTEGER,"
          "date BIGINT"
          ")");
    });
  }

//region Deed
  newDeed(Deed newDeed) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Deed");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Deed (id, description, type, value, date)"
        " VALUES (?,?,?,?,?)",
        [
          id,
          newDeed.description,
          newDeed.type,
          newDeed.value,
          newDeed.date.microsecondsSinceEpoch
        ]);
    return raw;
  }

  Future<List<Deed>> getAllDeeds() async {
    final db = await database;
    var res = await db.query("Deed");
    List<Deed> list =
        res.isNotEmpty ? res.map((c) => Deed.fromMap(c)).toList() : [];
    return list;
  }

  getAllDeedsByDate(DateTime dateTime) async {
    final db = await database;
    var res = await db.query("Deed",
        where: "date = ?", whereArgs: [dateTime.microsecondsSinceEpoch]);
    List<Deed> list =
        res.isNotEmpty ? res.map((c) => Deed.fromMap(c)).toList() : [];
    return list;
  }

  updateDeed(Deed newDeed) async {
    final db = await database;
    var res = await db.update("Deed", newDeed.toMap(),
        where: "id = ?", whereArgs: [newDeed.id]);
    return res;
  }

  deleteDeed(int id) async {
    final db = await database;
    var res = await db.delete("Deed", where: "id = ?", whereArgs: [id]);
    return res;
  }

  deleteAll() async {
    final db = await database;
    var res = await db.rawDelete("Delete * from Client");
    return res;
  }
//endregion
}
