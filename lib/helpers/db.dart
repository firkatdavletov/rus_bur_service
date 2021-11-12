import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/models/card.dart';
import 'package:rus_bur_service/models/report_item_builder.dart';
import 'package:sqflite/sqflite.dart';
import '../models/operation.dart';
import '../models/part.dart';
import '../models/report.dart';
import '../models/user.dart';

class DbProvider {
  Future<Database> database;

  DbProvider(this.database);

// -----------------Report------------------------------------------------------
  Future<void> insertReport(Report report) async {
    final db = await database;
    await db.insert(
      'reports',
      report.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertReport_2(BuildContext context) async {
    final db = await database;
    Map<String, Object?> map = Provider.of<ReportNotifier>(context, listen: false).toMap();
    print('map in insertReport_2 function:');
    print(map);
    await db.insert(
      'reports',
      map,
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> deleteReport(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM reports WHERE report_id = ?', ['$id']);
  }

  Future<List<Report>> reports() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('reports');
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      Report report = Report(
          id: maps[i]['report_id'],
          name: maps[i]['report_name'],
          userId: maps[i]['user_id'],
          company: maps[i]['customer_company'],
          customerName: maps[i]['customer_name'],
          customerEmail: maps[i]['customer_email'],
          customerPhone: maps[i]['customer_phone'],
          place: maps[i]['report_place'],
          date: maps[i]['report_date'],
          engineModel: maps[i]['engine_model'],
          engineNumb: maps[i]['engine_sn'],
          machineModel: maps[i]['machine_model'],
          machineNumb: maps[i]['machine_sn'],
          machineYear: maps[i]['machine_year'],
          opTime: maps[i]['engine_optime'],
          note: maps[i]['report_note']
      );
      return report;
    });
  }

  Future<int> upgradeReport(Report report) async {
    final db = await database;
    return await db.update(
        'reports',
        <String, Object>{
          'report_id': '${report.id}',
          'report_name': '${report.name}',
          'user_id' : '${report.userId}',
          'customer_company' : '${report.company}',
          'customer_name' : '${report.customerName}',
          'customer_email' : '${report.customerEmail}',
          'customer_phone' : '${report.customerPhone}',
          'report_place' : '${report.place}',
          'report_date' : '${report.date}',
          'engine_model' : '${report.engineModel}',
          'engine_sn' : '${report.engineNumb}',
          'machine_model' : '${report.machineModel}',
          'machine_sn' : '${report.machineNumb}',
          'machine_year' : '${report.machineYear}',
          'engine_optime' : '${report.opTime}',
          'report_note' : '${report.note}'
        },
        where: 'report_id = ?',
        whereArgs: [report.id]
    );
  }

  Future<int> upgradeReport_2(BuildContext context) async {
    final db = await database;
    return await db.update(
        'reports',
        Provider.of<ReportNotifier>(context, listen: false).toMap(),
        where: 'report_id = ?',
        whereArgs: [Provider.of<ReportNotifier>(context, listen: false).id]
    );
  }

//------------------User-------------------------------------------------------
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
        isAdmin: maps[i]['user_is_admin'] == 1? true : false
      );
    });
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    try {
      await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
    } catch (e, s) {
      print('Значение уже существует');
    }
  }

  Future<List<Map<String, dynamic>>> getUsersMap(String column, String arg) async {
    final db = await database;
    return db.query(
        'users',
      where: '$column = ?',
      whereArgs: [arg]
    );
  }

  Future<int> upgradeUser(User user) async {
    final db = await database;
    return await db.update(
        'users',
        <String, Object>{
          'user_firstname': '${user.firstName}',
          'user_lastname': '${user.lastName}',
          'user_middlename': '${user.middleName}',
          'user_login': '${user.login}',
          'user_is_admin': user.isAdmin? 1 : 0
        },
        where: 'user_id = ?',
      whereArgs: [user.userId]
    );
  }
  
  Future<void> deleteUser(int userId) async {
    final db = await database;
    await db.rawDelete('DELETE FROM users WHERE user_id = ?', ['$userId']);
  }

  Future<User> readUser(String column, String arg) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: '$column = ?',
        whereArgs: [arg]
    );

    Map<String, dynamic> map = maps.first;

    return User(
      userId: map['user_id'],
      firstName: map['user_firstname'],
      lastName: map['user_lastname'],
      middleName: map['user_middlename'],
      login: map['user_login'],
      isAdmin: map['user_is_admin'] == 1? true : false
    );
  }

  Future<User> readUserByLogin(String login) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'user_login = ?',
        whereArgs: [login]
    );

    Map<String, dynamic> map = maps.first;

    return User(
        userId: map['user_id'],
        firstName: map['user_firstname'],
        lastName: map['user_lastname'],
        middleName: map['user_middlename'],
        login: map['user_login'],
        isAdmin: map['user_is_admin'] == 1? true : false
    );
  }
//------------------Part--------------------------------------------------------
  Future<List<Part>> getParts() async {
    final db = await database;
    List<Map<String, dynamic>> parts = await db.query('parts');
    return List.generate(parts.length, (i) {
      return Part(
          id: parts[i]['part_id'],
          name: parts[i]['part_name'],
      );
    });
  }

  Future<String> getPartName (int id) async {
    final db = await database;
    List<Map<String, dynamic>> parts = await db.query(
        'parts',
        where: 'part_id = ?',
        whereArgs: ['$id']
    );
    return parts.first['part_name'];
  }

  insertPart(Part newPart) async {
    final db = await database;
    await db.insert(
      'parts',
      newPart.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  deletePart(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM parts WHERE part_id = ?', ['$id']);
    await db.rawDelete('DELETE FROM cards WHERE part_id = ?', ['$id']);
  }

  Future<int> upgradeUnitSelect(bool value, int id) async {
    final db = await database;
    return await db.update(
        'units',
        <String, Object>{
          'is_selected': value? 1 : 0,
        },
        where: 'unit_id = ?',
        whereArgs: [id]
    );
  }

  Future<int> upgradeCardSelectByUnit(bool value, int id) async {
    final db = await database;
    return await db.update(
      'cards',
        <String, Object>{
          'is_selected': value? 1 : 0,
        },
        where: 'unit_id = ?',
        whereArgs: [id]
    );
  }

  Future<int> upgradeCardSelect(bool value, int id) async {
    final db = await database;
    return await db.update(
        'cards',
        <String, Object>{
          'is_selected': value? 1 : 0,
        },
        where: 'card_id = ?',
        whereArgs: [id]
    );
  }

  Future<List<Operation>> getOperations(String column, dynamic value) async {
    final db = await database;
    List<Map<String, dynamic>> operations = await db.query(
        'operations',
        where: '$column = ?',
        whereArgs: ['$value']
    );
    return List.generate(operations.length, (i) {
      return Operation(
          id: operations[i]['operation_id'],
          name: operations[i]['operation_name'],
          partId: operations[i]['part_id'],
          isRequired: operations[i]['is_required'] == 1? true : false
      );
    });
  }

  Future<Operation> getOperationById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
        'operations',
        where: 'operation_id = ?',
        whereArgs: ['$id']
    );
    return Operation(
        id: maps.first['operation_id'],
        name: maps.first['operation_name'],
        partId: maps.first['part_id'],
        isRequired: maps.first['is_required'] == 1? true : false
    );
  }

  insertOperation(Operation operation) async {
    final db = await database;
    await db.insert(
      'operations',
      operation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  deleteOperation(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM operations WHERE operation_id = ?', ['$id']);
  }
}
