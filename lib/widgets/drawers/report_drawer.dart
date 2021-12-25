import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/home_page.dart';

import 'package:rus_bur_service/pages/login_page.dart';

class ReportDrawer extends StatelessWidget {

  const ReportDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final drawerItems = ListView(
        children: [
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
