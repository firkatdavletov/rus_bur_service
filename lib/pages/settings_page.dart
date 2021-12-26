import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/email_message_settings.dart';
import 'package:rus_bur_service/pages/users_page.dart';
import 'package:rus_bur_service/helpers/password_provider.dart';
import 'package:rus_bur_service/widgets/drawers/app_drawer.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../main.dart';
import 'home_page.dart';
import 'parts_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()
                )
            );
          },
        ),
        title: Text('Настройки'),
      ),
      drawer: ReportDrawer(),
      body: ListView(
        children: [
          ListTile(
            title: Text('Пользователи'),
            subtitle: Text('Добавление, удаление и редактирование пользователей'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UsersPage()
                ),
              );
            },
          ),
          ListTile(
            title: Text('Диагностические карты'),
            subtitle: Text('Добавление, удаление и редактирование карт'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PartsPage()
                ),
              );
            },
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text('Параметры сообщения'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmailMessageSettings()
                ),
              );
            },
          ),
          ListTile(
            title: Text('Удаление базы данных'),
            subtitle: Text('Удалить все данные'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Удалить все данные?'),
                      content: Row(
                        children: [
                          OutlinedButton(
                              onPressed: () async {
                                await deleteDatabase(join(await getDatabasesPath(), 'rb_service_database.db'));
                                PasswordProvider().deleteAllPasswords();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()
                                    )
                                );
                              },
                              child: Text('Удалить')
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Отмена')
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
