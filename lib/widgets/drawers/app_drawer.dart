import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/pages/mailer_page.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';
import 'package:rus_bur_service/pages/home_page.dart';
import 'package:rus_bur_service/pages/login_page.dart';
import 'package:rus_bur_service/pages/settings_page.dart';


class AppDrawer extends StatelessWidget {
  final User user;
  const AppDrawer({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final drawerItems = ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('${user.firstName} ${user.lastName}'),
              accountEmail: Text('ID: ${user.userId} Статус: ${user.isAdmin? 'Администратор':'Пользователь'}'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Text(
                    user.firstName[0].toUpperCase()+
                        user.lastName[0].toUpperCase()
                ),
              ),
          ),
          ListTile(
            title: Text('Главная страница'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage()
                  )
              );
            },
          ),
          Visibility(
            visible: user.isAdmin,
            child: ListTile(
              title: Text('Настройки'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage()
                    )
                );
              },
            ),
          ),
          ListTile(
            title: Text('Выйти'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage()
                ),
              );
            },
          )
        ]
    );
    return Drawer(
      child: drawerItems,
    );
  }
}
