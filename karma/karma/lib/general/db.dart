import 'dart:io';

import 'package:karma/models/alarm.dart';
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
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "Deeds.db";
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $tableDeed ("
          "$columnDeedId integer primary key autoincrement,"
          "$columnName TEXT,"
          "$columnDescription TEXT,"
          "$columnType BIT,"
          "$columnValue INTEGER,"
          "$columnDate BIGINT"
          ")");

      await db.execute('''
          create table $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer)
        ''');
    });
  }

//region Deed
  void newDeed(Deed newDeed) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Deed");
    await db.insert(tableDeed, newDeed.toMap());
  }

  Future<List<Deed>> getAllDeeds() async {
    final db = await database;
    var res = await db.query("Deed");
    List<Deed> list =
        res.isNotEmpty ? res.map((c) => Deed.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<DateTime>> getAllDates() async {
    return getAllDeeds()
        .then((value) => value.map((e) => e.date).toSet().toList());
  }

  getAllDeedsByDate(DateTime dateTime) async {
    final db = await database;
    var res = await db.query("Deed",
        where: "date = ?", whereArgs: [dateTime.microsecondsSinceEpoch]);
    List<Deed> list =
        res.isNotEmpty ? res.map((c) => Deed.fromMap(c)).toList() : [];
    return list;
  }

  void updateDeed(Deed newDeed) async {
    final db = await database;
    await db.update("Deed", newDeed.toMap(),
        where: "id = ?", whereArgs: [newDeed.id]);
  }

  void deleteDeed(int id) async {
    final db = await database;
    await db.delete("Deed", where: "id = ?", whereArgs: [id]);
  }

  void deleteAll() async {
    final db = await database;
    await db.rawDelete("Delete * from Client");
  }
//endregion

//region Alarm
  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    await db.insert(tableAlarm, alarmInfo.toMap());
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
//endregion
}
