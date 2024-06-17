import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class UserTable {
  final String tableName;
  final String userIdCol;
  final String createdCol;
  final String updatedCol;
  final String emailCol;
  final String passwordCol;
  final String usernameCol;
  final String genderCol;
  final String phoneNoCol;
  final String remarkCol;
  final String referenceCol;
  final String isDeletedCol;

  UserTable({
    required this.tableName,
    required this.userIdCol,
    required this.createdCol,
    required this.updatedCol,
    required this.emailCol,
    required this.passwordCol,
    required this.usernameCol,
    required this.genderCol,
    required this.phoneNoCol,
    required this.remarkCol,
    required this.referenceCol,
    required this.isDeletedCol,
  });

  static UserTable getTableProps() => UserTable(
        tableName: "user",
        userIdCol: "id",
        createdCol: "created",
        updatedCol: "updated",
        emailCol: "email",
        passwordCol: "password",
        usernameCol: "username",
        genderCol: "gender",
        phoneNoCol: "phono_no",
        remarkCol: "remark",
        referenceCol: "reference",
        isDeletedCol: "is_deleted",
      );

  static String getCreateQuery() {
    final userTable = getTableProps();

    return '''
      CREATE TABLE IF NOT EXISTS ${userTable.tableName} (
        ${userTable.userIdCol} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${userTable.createdCol} TEXT NOT NULL,
        ${userTable.updatedCol} TEXT NOT NULL,
        ${userTable.emailCol} TEXT NOT NULL,
        ${userTable.passwordCol} TEXT NOT NULL,
        ${userTable.usernameCol} TEXT,
        ${userTable.genderCol} TEXT,
        ${userTable.phoneNoCol} TEXT,
        ${userTable.remarkCol} TEXT,
        ${userTable.referenceCol} TEXT,
        ${userTable.isDeletedCol} INTEGER NOT NULL DEFAULT 0
      )
    ''';
  }

  static Future<Map<String, dynamic>?> addUser({
    required Database database,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final userTable = getTableProps();

      String currentDateTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      final userId = await database.insert(
        userTable.tableName,
        {
          userTable.createdCol: currentDateTime,
          userTable.updatedCol: currentDateTime,
          userTable.emailCol: email,
          userTable.passwordCol: password,
          userTable.usernameCol: username,
        },
      );

      if (userId == -1) {
        return null;
      }

      final List<Map<String, dynamic>> result = await database.query(
        userTable.tableName,
        where: '${userTable.userIdCol} = ?',
        whereArgs: [userId],
      );

      if (result.isNotEmpty) {
        return result.first;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> login({
    required Database database,
    required String email,
    required String password,
  }) async {
    try {
      final userTable = getTableProps();

      final List<Map<String, dynamic>> result = await database.query(
        userTable.tableName,
        where: '${userTable.emailCol} = ? AND ${userTable.passwordCol} = ?',
        whereArgs: [email, password],
      );

      if (result.isNotEmpty) {
        return result.first;
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
