import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/pages/email_message_settings_page.dart';
import 'package:rus_bur_service/pages/parts_settings_page.dart';
import 'package:rus_bur_service/pages/picture_settings_page.dart';
import 'package:rus_bur_service/pages/users_page.dart';
import 'package:rus_bur_service/helpers/password_provider.dart';
import 'package:rus_bur_service/widgets/drawers/app_drawer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../controller/user_notifier.dart';
import 'home_page.dart';

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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blueGrey, Colors.lightBlueAccent]
              )
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))
        ),
        title: Text('Настройки'),
      ),
      drawer: AppDrawer(user: Provider.of<UserNotifier>(context, listen: false).user,),
      body: Column(
        children: [
          Expanded(
            child: ListView(
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
                          builder: (context) => PartsSettingPage()
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
                          builder: (context) => EmailMessageSettingsPage()
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Фотографии'),
                  subtitle: Text('Настройки изображения'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PictureSettingsPage()
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()
                        )
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back_ios_outlined),
                      SizedBox(width: 10,),
                      Text('Назад')
                    ],
                  )
              ),
          )
        ],
      )
    );
  }
}
