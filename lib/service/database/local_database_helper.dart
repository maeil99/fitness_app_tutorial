import 'package:fitness_app_tutorial/service/database/database_exception.dart';
import 'package:fitness_app_tutorial/service/database/user_table.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/web.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  Database? _db;

  static const String _dbName = "fitness.db";

  static const int _dbVersion = 2;

  LocalDatabaseHelper._internal();

  static final LocalDatabaseHelper _singleton = LocalDatabaseHelper._internal();

  factory LocalDatabaseHelper() {
    return _singleton;
  }

  Database getDatabase() {
    _db ?? initDatabase();
    if (_db != null) {
      return _db!;
    }
    throw ErrorDbNotOpen;
  }

  Future<void> initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), _dbName);
      _db = await openDatabase(
        path,
        version: _dbVersion,
        onCreate: _createDb,
        onUpgrade: (db, oldVersion, newVersion) async {
          await db.execute(UserTable.getCreateQuery());
        },
      );
    } on MissingPlatformDirectoryException {
      throw ErrorGetDocumentDirectory();
    } catch (e) {
      Logger().e(e);
      throw FailedOpenDatabase(e);
    }
  }

  Future<void> _createDb(Database db, int newVersion) async {
    debugPrint("========= creating tables ========");
    await db.execute(UserTable.getCreateQuery());
  }
}
