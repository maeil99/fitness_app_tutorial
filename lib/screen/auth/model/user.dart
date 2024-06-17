import 'package:fitness_app_tutorial/service/database/local_database_helper.dart';
import 'package:fitness_app_tutorial/service/database/user_table.dart';
import 'package:sqflite/sqflite.dart';

enum Gender {
  male,
  female,
}

class User {
  final int userId;
  final DateTime created;
  final DateTime updated;
  final String email;
  final String password;
  final String? username;
  final Gender? gender;
  final String? phoneNo;
  final String? remark;
  final String? reference;
  final int isDeleted;

  User({
    required this.userId,
    required this.created,
    required this.updated,
    required this.email,
    required this.password,
    this.username,
    this.gender,
    this.phoneNo,
    this.remark,
    this.reference,
    required this.isDeleted,
  });

  static Future<User> fromDatabase(Map<String, dynamic> json) async {
    final UserTable userTable = UserTable.getTableProps();

    return User(
      userId: json[userTable.userIdCol],
      created: DateTime.parse(json[userTable.createdCol]),
      updated: DateTime.parse(json[userTable.updatedCol]),
      email: json[userTable.emailCol],
      password: json[userTable.passwordCol],
      username: json[userTable.usernameCol],
      gender: json[userTable.genderCol],
      phoneNo: json[userTable.phoneNoCol],
      remark: json[userTable.remarkCol],
      reference: json[userTable.referenceCol],
      isDeleted: json[userTable.isDeletedCol],
    );
  }

  static final Database _database = LocalDatabaseHelper().getDatabase();

  static Future<User?> addNewUser({
    required String username,
    required String email,
    required String password,
  }) async {
    var result = await UserTable.addUser(
      database: _database,
      username: username,
      email: email,
      password: password,
    );

    if (result == null) {
      return null;
    }

    return await fromDatabase(result);
  }

  static Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    var result = await UserTable.login(
      database: _database,
      email: email,
      password: password,
    );

    if (result == null) {
      return null;
    }

    return await fromDatabase(result);
  }
}
