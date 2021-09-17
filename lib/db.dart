import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'model.dart';
import 'models/user.dart';

class DbProvider {
  Future<Database> database;

  DbProvider(this.database);

  Future<void> insertReport(Report report) async {
    final db = await database;
    await db.insert(
      'reports',
      report.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertCustomer(Customer customer) async {
    final db = await database;
    await db.insert(
      'customers',
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMachine(Machine machine) async {
    final db = await database;
    await db.insert(
      'machines',
      machine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertEngine(Engine engine) async {
    final db = await database;
    await db.insert(
      'engines',
      engine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Report>> reports() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('reports');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Report(
        id: maps[i]['id'],
        name: maps[i]['name'],
        userId: maps[i]['user_id'],
        customerId: maps[i]['customer_id'],
        place: maps[i]['place'],
        date: maps[i]['date'],
        engineId: maps[i]['engine_id'],
        machineId: maps[i]['machine_id'],
        note: maps[i]['note']
      );
    });
  }
  Future<List<User>> users() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User(
        userId: maps[i]['user_id'],
        firstName: maps[i]['user_firstname'],
        lastName: maps[i]['user_lastname'],
        middleName: maps[i]['user_middlename'],
        login: maps[i]['user_login'],
      );
    });
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }
  
  Future<void> deleteUser(int userId) async {
    final db = await database;
    await db.rawDelete('DELETE FROM users WHERE user_id = ?', ['$userId']);
  }

  Future<User> readUser(int userId) async {
    final db = await database;
    print('db.isOpen: ${db.isOpen}');

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'user_id = ?',
        whereArgs: [userId]
    );

    Map<String, dynamic> map = maps.first;

    return User(
      userId: map['user_id'],
      firstName: map['user_firstname'],
      lastName: map['user_lastname'],
      middleName: map['user_middlename'],
      login: map['user_login'],
    );
  }
}
