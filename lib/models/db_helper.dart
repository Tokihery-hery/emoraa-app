import 'package:emoraa/models/house_model.dart';
import "package:flutter/material.dart";
import "package:sqflite/sqflite.dart" as sql;

class SQLHelper with ChangeNotifier {
  String _searchHouse = '';
  String get searchHouse => _searchHouse;
  set searchHouse(String value) {
    _searchHouse = value;
    notifyListeners();
  }

  List<Housse> _housses = [];
  List<Housse> get housses {
    return _searchHouse != ''
        ? _housses
            .where((element) =>
                element.title.toLowerCase().contains(_searchHouse) ||
                element.descrption.toLowerCase().contains(_searchHouse))
            .toList()
        : _housses;
  }

  static Future<void> createTable(sql.Database database) async {
    await database.execute('''
      CREATE TABLE chambres (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        owner_id INTEGER,
        title TEXT UNIQUE NOT NULL,
        price INTEGER,
        ch_count INTEGER,
        description TEXT,
        has_wc INTEGER DEFAULT 0,
        has_douche INTEGER DEFAULT 0,
        has_checken INTEGER DEFAULT 0,
        created_at TEXT DEFAULT (DATETIME('now'))
      )
    ''');

    await database.execute('''
      CREATE TABLE loyers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        owner_id INTEGER,
        firstname TEXT UNIQUE NOT NULL,
        lastname TEXT UNIQUE NOT NULL,
        date TEXT DEFAULT (DATETIME('now')),
        gender TEXT DEFAULT 'm',
        avatar TEXT,
        address TEXT NOT NULL,
        state INTEGER,
        identify TEXT UNIQUE NOT NULL,
        phone TEXT NOT NULL,
        house_id INTEGER,
        payment_ids INTEGER
      )
    ''');

    await database.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        phone TEXT,
        email TEXT UNIQUE NOT NULL,
        address TEXT,
        password TEXT,
        created_at TEXT DEFAULT (DATETIME('now')),
        loyer_ids INTEGER,
        house_ids INTEGER
      )
    ''');

    await database.execute('''
      CREATE TABLE payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        qr_img_path TEXT,
        amount INTEGER,
        loyer_id INTEGER,
        date TEXT,
        state INTEGER DEFAULT 0,
        created_at TEXT DEFAULT (DATETIME('now'))
      )
    ''');
  }

  static Future<sql.Database> db() async {
    var databasesPath = await sql.getDatabasesPath();
    String path = '${databasesPath}emoraa.db';
    debugPrint(path);
    return sql.openDatabase(path, version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  Future<int> insertChambre(Housse newHousse) async {
    final db = await SQLHelper.db();
    return db.transaction((txn) async {
      return await txn
          .insert('chambres', newHousse.toMap(),
              conflictAlgorithm: sql.ConflictAlgorithm.replace)
          .then((value) {
        final housseNew = Housse(
            id: value,
            title: newHousse.title,
            price: newHousse.price,
            descrption: newHousse.descrption,
            chCount: newHousse.chCount,
            createdAt: newHousse.createdAt,
            hasChecken: newHousse.hasChecken,
            hasDouche: newHousse.hasDouche,
            hasWC: newHousse.hasWC
            );
        _housses.add(housseNew);
        notifyListeners();

        return value;
      });
    });
  }

  Future<List<Housse>> getChambres() async {
    final db = await SQLHelper.db();
    return db.transaction((txn) async {
      return await txn.query('chambres', orderBy: 'id').then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        List<Housse> housseList = List.generate(
            converted.length, (index) => Housse.fromString(converted[index]));
        _housses = housseList;
        return _housses;
      });
    });
  }

  static Future<List<Map<String, dynamic>>> getChambre(int id) async {
    final db = await SQLHelper.db();
    return db.query('chambres', where: "id =?", whereArgs: [id], limit: 1);
  }

  Future<int> updateChambre(int id, Housse updatedHousse) async {
    final db = await SQLHelper.db();
    final data = updatedHousse.toMap();
    return db.transaction((txn) async {
      return await txn
          .update('chambres', data,
              where: "id = ?",
              whereArgs: [id],
              conflictAlgorithm: sql.ConflictAlgorithm.replace)
          .then((value) {
        final index = _housses.indexWhere((housse) => housse.id == id);
        if (index != -1) {
          _housses[index] = updatedHousse;
        }
        notifyListeners();
        return value;
      });
    });
  }

  Future<List<Housse>> deleteCh(int id) async {
    final db = await SQLHelper.db();
    return db.transaction((txn) async {
      return await txn
          .delete('chambres', where: "id = ?", whereArgs: [id]).then((value) {
        var houssesList =
            _housses.where((element) => element.id != id).toList();
        _housses = houssesList;
        notifyListeners();

        return _housses;
      });
    });
  }
}
