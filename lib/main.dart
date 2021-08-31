import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/login_page.dart';
import 'package:sqflite/sqflite.dart';
import 'db.dart';
import 'package:path/path.dart';
import 'migration_scripts.dart';

late DbProvider db;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'rb_service_database.db'),
    version: numbScripts,
    onCreate: (db, version) async {
      for (int i = 1; i <= numbScripts; i++) {
        await db.execute(migrationScripts[i-1]);
      }
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      for (int i = oldVersion + 1; i <= newVersion; i++) {
        await db.execute(migrationScripts[i-1]);
      }
    },

  );
  db = DbProvider(database);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'РусБурСервис',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
