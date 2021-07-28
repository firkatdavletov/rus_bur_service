import 'package:flutter/material.dart';
import 'package:rus_bur_service/db.dart';
import 'package:rus_bur_service/pages/login_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
export 'package:rus_bur_service/main.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
