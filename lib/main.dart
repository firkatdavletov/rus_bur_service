import 'package:flutter/material.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/controller/spare_notifier.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/controller/machine_notifier.dart';
import 'package:rus_bur_service/pages/login_page.dart';
import 'package:rus_bur_service/pages/registration_page.dart';

import 'package:sqflite/sqflite.dart';
import 'controller/diagnostic_cards_notifier.dart';
import 'controller/email_message_notifier.dart';
import 'controller/operation_notifier.dart';
import 'controller/part_notifier.dart';
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
          ChangeNotifierProvider(create: (_) => ReportNotifier()),
          ChangeNotifierProvider(create: (_) => MachineNotifier()),
          ChangeNotifierProvider(create: (_) => DiagnosticCardsNotifier()),
          ChangeNotifierProvider(create: (_) => PictureNotifier()),
          ChangeNotifierProvider(create: (_) => EmailMessageNotifier()),
          ChangeNotifierProvider(create: (_) => DiagnosticCardsNotifier()),
          ChangeNotifierProvider(create: (_) => SpareNotifier()),
          ChangeNotifierProvider(create: (_) => OperationNotifier()),
          ChangeNotifierProvider(create: (_) => PartNotifier())
        ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {

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
                scaffoldBackgroundColor: Color.fromRGBO(244, 244, 244, 10),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent
                  )
                )
              ),
              home: snapshot.data.length == 0? RegistrationPage(): LoginPage(),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'РусБурСервис',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      Icon(Icons.error_outline),
                      Text('Что-то пошло не так...'),
                      Text('${snapshot.error}')
                    ],
                  ),
                ),
              ),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'РусБурСервис',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        }
    );
  }
}
