
import 'package:flutter/material.dart';
import 'package:rus_bur_service/controller/customer_notifier.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/controller/machine_notifier.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/login_page.dart';
import 'package:rus_bur_service/pages/registration_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';
import 'package:sqflite/sqflite.dart';
import 'controller/diagnostic_cards_notifier.dart';
import 'controller/picture_notifier.dart';
import 'helpers/db.dart';
import 'package:path/path.dart';
import 'helpers/migration_scripts.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

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

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserNotifier()),
          ChangeNotifierProvider(create: (_) => CustomerNotifier()),
          ChangeNotifierProvider(create: (_) => ReportNotifier()),
          ChangeNotifierProvider(create: (_) => MachineNotifier()),
          ChangeNotifierProvider(create: (_) => DiagnosticCardsNotifier()),
          ChangeNotifierProvider(create: (_) => PictureNotifier())
        ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // _getKey(String key) async {
  //   Future<String?> _temp = PasswordProvider().getPassword(key);
  //   return _temp;
  // }

  _getUser() async {
    List<User> _maps = await db.users();
    return _maps;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'РусБурСервис',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: snapshot.data.length == 0? RegistrationPage(): LoginPage(),
            );
          } else if (snapshot.hasError) {
            print('snapshot error: ${snapshot.error}');
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'РусБурСервис',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: ErrorPage(),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'РусБурСервис',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: WaitingPage(),
            );
          }
        }
    );
  }
}
