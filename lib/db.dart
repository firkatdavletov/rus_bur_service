import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'user.dart';
// Open the database
Future<Database> initDB() async {
  // Open the database and store the reference.
  final database = openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    // When the database is first created, create a table to store users.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, login TEXT, password TEXT)',
      );
    },
    version: 1,
  );
  final db = await database;
  return db;
}

// Define a function that inserts users the database
Future<void> insertUser(User user, Database db) async {
  await db.insert(
    'users',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// A method that retrieves all the users from the users table.
Future<List<User>> users(Database db) async {
  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('users');
  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'],
      name: maps[i]['name'],
      login: maps[i]['login'],
      password: maps[i]['password'],
    );
  });
}

Future<void> updateUser(User user, Database db) async {
  // Update the given User.
  await db.update(
    'users',
    user.toMap(),
    // Ensure that the User has a matching id.
    where: 'id = ?',
    // Pass the User's id as a whereArg to prevent SQL injection.
    whereArgs: [user.id],
  );
}

Future<void> deleteUser(int id, Database db) async {
  // Remove the User from the database.
  await db.delete(
    'users',
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the User's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}