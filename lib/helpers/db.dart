import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/models/agreed_part.dart';
import 'package:rus_bur_service/models/diagnostic_card.dart';
import 'package:rus_bur_service/models/picture.dart';
import 'package:rus_bur_service/models/spare.dart';
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
          opTime_1: maps[i]['engine_optime_1'],
          opTime_2: maps[i]['engine_optime_2'],
          opTime_3: maps[i]['engine_optime_3'],
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
          'engine_optime' : '${report.opTime_1}',
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
    } catch (e) {
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

  Future<List<Part>> getCheckedParts(int reportId) async {
    final db = await database;
    List<Map<String, dynamic>> parts = await db.query('parts');
    var agreedParts = await db.rawQuery(
        'SELECT part_id FROM agreed_parts WHERE report_id = ?',
      ['$reportId']
    );
    return List.generate(parts.length, (i) {
      Part _checkedPart = Part(
        id: parts[i]['part_id'],
        name: parts[i]['part_name'],
      );
      for (Object e in agreedParts) {
        if (e.toString() == '{part_id: ${_checkedPart.id}}') {
          _checkedPart.isChecked = true;
        }
      }
      return _checkedPart;
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

  Future<bool> partIsExists (String name) async {
    final db = await database;
    List<Map<String, dynamic>> parts = await db.query(
        'parts',
        where: 'part_name = ?',
        whereArgs: ['$name']
    );
    return parts.isNotEmpty? true : false;
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
    //await db.rawDelete('DELETE FROM cards WHERE part_id = ?', ['$id']);
  }

  //------------------------AgreedParts-----------------------------------------

  insertAgreedPart(AgreedPart agreedPart) async {
    final db = await database;

    await db.insert(
        'agreed_parts',
        agreedPart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort
    );
  }

  deleteAgreedPart(AgreedPart agreedPart) async {
    final db = await database;

    await db.rawDelete(
        'DELETE FROM agreed_parts WHERE report_id = ? AND part_id =?',
      ['${agreedPart.reportId}', '${agreedPart.partId}']
    );
  }

  deleteAllAgreedParts(int reportId) async {
    final db = await database;

    await db.rawDelete(
        'DELETE FROM agreed_parts WHERE report_id = ?',
        [reportId]
    );
  }

  //-----------------------Operations-------------------------------------------

  getAgreedOperations(List<String> partsId) async {
    final db = await database;
    String sql = 'part_id = ?';
    for (int i = 0; i < partsId.length-1; i++) {
      sql += ' OR part_id = ?';
    }
    List<Map<String, dynamic>> operations = await db.query(
        'operations',
        where: sql,
        whereArgs: partsId
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

  //-----------------Cards------------------------------------------------------
  Future<List<DiagnosticCard>> getCards(int reportId) async {
    final db = await database;
    List<Map<String, dynamic>> cards = await db.query(
        'cards',
        where: 'report_id = ?',
        whereArgs: ['$reportId']
    );
    return List.generate(cards.length, (i) {
      return DiagnosticCard(
          id: cards[i]['card_id'],
          name: cards[i]['card_name'],
          operationId: cards[i]['operation_id'],
          reportId: cards[i]['report_id'],
          conclusion: cards[i]['conclusion'],
          description: cards[i]['description'],
          area: cards[i]['area'],
          damage: cards[i]['damage'],
          priority: cards[i]['priority'],
          recommend: cards[i]['recommend'],
          time: cards[i]['time'],
          effect: cards[i]['effect'],
          manHours: cards[i]['man_hours']
      );
    });
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

  insertCard(DiagnosticCard card) async {
    final db = await database;
    await db.insert(
        'cards',
        card.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  deleteCard(String cardId) async {
    final db = await database;
    await db.delete(
        'cards',
        where: 'card_id = ?',
        whereArgs: [cardId]
    );
  }

  upgradeCard(DiagnosticCard newCard) async {
    final db = await database;
    await db.update(
        'cards',
      <String, Object>{
        'conclusion': newCard.conclusion,
        'description' : newCard.description,
        'damage' : newCard.damage,
        'priority' : newCard.priority,
        'recommend' : newCard.recommend,
        'time' : newCard.time,
        'effect' : newCard.effect,
        'man_hours' : newCard.manHours
      },
      where: 'card_id = ?',
      whereArgs: [newCard.id]
    );
  }

  //------------------------PICTURE---------------------------------------------
  insertPicture(AppPicture picture) async {
    final db = await database;
    await db.insert(
      'pictures',
      picture.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort
    );
  }

  Future<List<AppPicture>> getPicture(int reportId, String cardId) async {
    final db = await database;
    List<Map<String, dynamic>> pictures = await db.query(
        'pictures',
        where: 'report_id = ? and card_id = ?',
        whereArgs: ['$reportId', '$cardId']
    );
    return List.generate(pictures.length, (i) {
      return AppPicture(
          id: pictures[i]['picture_id'],
          name: pictures[i]['picture_name'],
          reportId: pictures[i]['report_id'],
          cardId: pictures[i]['card_id'],
          picture: pictures[i]['picture'],
          description: pictures[i]['picture_description']
      );
    });
  }

  Future<List<List<int>>> getImageFiles(int reportId, String cardId) async {
    final db = await database;
    List<Map<String,  dynamic>> images = await db.query(
      'pictures',
      where: 'report_id = ? and card_id = ?',
      whereArgs: ['$reportId', '$cardId']
    );

    return List.generate(images.length, (i) {
      return images[i]['picture'];
    });
  }

  Future<void> deletePictures(int reportId) async {
    final db = await database;
    await db.rawDelete(
        'DELETE FROM pictures WHERE report_id = ?',
        ['$reportId']
    );
  }
  Future<void> deletePicture(int pictureId) async {
    final db = await database;
    await db.rawDelete(
        'DELETE FROM pictures WHERE picture_id = ?',
        ['$pictureId']
    );
  }


//-----------------------SPARES-------------------------------------------------
  insertSpare(Spare spare) async {
    final db = await database;
    await db.insert(
        'spares',
        spare.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail
    );
  }

  Future<void> deleteSpares(int operationId) async {
    final db = await database;
    await db.rawDelete(
        'DELETE FROM spares WHERE operation_id = ?',
        ['$operationId']
    );
  }
  Future<void> deleteSpare(int spareId) async {
    final db = await database;
    await db.rawDelete(
        'DELETE FROM spares WHERE spare_id = ?',
        ['$spareId']
    );
  }

  Future<int> upgradeSpare(Spare spare) async {
    final db = await database;
    return await db.update(
        'spares',
        spare.toMap(),
        where: 'spare_id = ?',
        whereArgs: ['${spare.id}']
    );
  }

  Future<List<Spare>> getSpare(String cardId) async {
    final db = await database;
    List<Map<String, dynamic>> spares = await db.query(
        'spares',
        where: 'card_id = ?',
        whereArgs: [cardId]
    );
    return List.generate(spares.length, (i) {
      return Spare(
          id: spares[i]['spare_id'],
          name: spares[i]['spare_name'],
          issue: spares[i]['spare_issue'],
          cardId: spares[i]['card_id'],
          number: spares[i]['spare_number'],
          quantity: spares[i]['spares_quantity'],
          measure: spares[i]['spare_measure'],
          priority: spares[i]['spare_priority']
      );
    });
  }
}

