import 'dart:io';

import 'package:collection/collection.dart';
import 'package:karma/models/alarm.dart';
import 'package:karma/models/deed.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database?> get database async {
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
          CREATE TABLE $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnAlarmDescription TEXT,
          $columnDateTime TEXT,
          $columnPending BIT)
        ''');
    });
  }

//region Deed
  void newDeed(Deed newDeed) async {
    final db = await database;
    await db?.insert(tableDeed, newDeed.toMap());
  }

  Future<List<Deed>> getAllDeeds() async {
    final db = await database;
    var res = await db?.query("Deed");
    List<Deed> list = (res?.isNotEmpty == true
        ? res?.map((c) => Deed.fromMap(c)).toList()
        : [])!;
    return list;
  }

  Future<List<Deed>> getAllDeedsForDate(DateTime? date) async {
    final db = await database;
    var res = await db?.query("Deed",
        where: date?.millisecondsSinceEpoch != null
            ? '${columnDate} = ${date?.millisecondsSinceEpoch}'
            : 'TRUE');
    List<Deed> list = (res?.isNotEmpty == true
        ? res?.map((c) => Deed.fromMap(c)).toList()
        : [])!;
    return list;
  }

  Future<List<DateTime?>> getAllDates() async {
    return getAllDeeds().then((value) {
      var list = value.map((e) => e.date).toList();
      List<DateTime?> filteredList = [];
      list.forEach((date) {
        if (filteredList.firstWhereOrNull((element) =>
                element?.day == date?.day &&
                element?.month == date?.month &&
                element?.year == date?.year) !=
            null) {
          filteredList.add(date);
        }
      });

      filteredList.sort((d1, d2) => d1?.compareTo(d2 ?? DateTime.now()) ?? 0);
      return filteredList;
    });
  }

  void updateDeed(Deed newDeed) async {
    final db = await database;
    await db?.update("Deed", newDeed.toMap(),
        where: "id = ?", whereArgs: [newDeed.id]);
  }

  void deleteDeed(int id) async {
    final db = await database;
    await db?.delete("Deed", where: "id = ?", whereArgs: [id]);
  }

  void deleteAll() async {
    final db = await database;
    await db?.rawDelete("Delete * from Client");
  }

//endregion

//region Alarm
  Future<int?> insertAlarm(AlarmInfo alarmInfo) async {
    var db = await database;
    return db?.insert(tableAlarm, alarmInfo.toMap());
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await database;
    var result = await db?.query(tableAlarm);
    result?.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int?> deleteAlarm(int id) async {
    var db = await database;
    return await db
        ?.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
//endregion
}
