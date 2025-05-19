import 'dart:io';
import 'package:flutter/animation.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  static final DbController _instance = DbController._internal();
  late Database _database;

  DbController._internal();

  Database get database => _database;

  factory DbController() {
    return _instance;
  }

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    String path = join(directory.path, 'app_db.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE home ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT NOT NULL,'
            'time TEXT NOT NULL,'
            'seconds INTEGER NOT NULL,'
            'original_seconds INTEGER NOT NULL'
            ')');

      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {},
      onDowngrade: (Database db, int oldVersion, int newVersion) {},
    );
  }
}

