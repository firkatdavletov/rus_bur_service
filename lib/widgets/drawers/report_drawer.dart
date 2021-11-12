import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/diagnostic_cards_page.dart';
import 'package:rus_bur_service/pages/home_page.dart';

import 'package:rus_bur_service/pages/login_page.dart';
import 'package:rus_bur_service/pages/report_page2.dart';
import 'package:rus_bur_service/pages/report_page3.dart';
import 'package:rus_bur_service/pages/report_page4.dart';


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
            title: Text('Основная информация'),
            onTap: () {

            },
          ),
          ListTile(
            title: Text('Данные заказчика'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportPage2()
                  )
              );
            },
          ),
          ListTile(
            title: Text('Данные машины'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportPage3()
                  )
              );
            },
          ),
          ListTile(
            title: Text('Примечания'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportPage4()
                  )
              );
            },
          ),
          ListTile(
            title: Text('Диагностические карты'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DiagnosticCardsPage()
                  )
              );
            },
          ),
          ListTile(
            title: Text('Сохранить отчёт'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()
                ),
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
