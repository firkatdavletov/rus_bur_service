import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'user.dart';
// Open the database
void openDB() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    // When the database is first created, create a table to store users.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, login TEXT, password TEXT, isAdmin BOOL)',
      );
    },
    version: 1,
  );

  // Define a function that inserts users the database
  Future<void> insertUser(User user) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('-----Insert user--------');
  }

  // A method that retrieves all the users from the users table.
  Future<List<User>> users() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        login: maps[i]['login'],
        password: maps[i]['password'],
        isAdmin: maps[i]['isAdmin']
      );
    });
  }

  Future<void> updateUser(User user) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given User.
    await db.update(
      'dogs',
      user.toMap(),
      // Ensure that the User has a matching id.
      where: 'id = ?',
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
    print('-----Update user--------');
  }

  Future<void> deleteUser(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the User from the database.
    await db.delete(
      'users',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
    print('-----Delete user--------');
  }

  // Create an User and add it to the users table
  var admin = User(
    id: 0,
    name: 'Admin',
    login: 'admin',
    password: '12345',
    isAdmin: true,
  );

  await insertUser(admin);

  // Now, use the method above to retrieve all the users.
  print(await users()); // Prints a list that include Admin.

  // Update Admin's password and save it to the database.
  admin = User(
    id: admin.id,
    name: admin.name,
    login: admin.login,
    password: '67890',
    isAdmin: admin.isAdmin,
  );
  await updateUser(admin);

  // Print the updated results.
  print(await users()); // Prints Admin with new password.

  // Delete Admin from the database.
  await deleteUser(admin.id);

  // Print the list of dogs (empty).
  print(await users());
}