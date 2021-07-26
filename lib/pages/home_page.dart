import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:rus_bur_service/db.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _homePageTitle = 'Домашняя страница';

    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('accountName'),
      accountEmail: Text('accountEmail'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: FlutterLogo(size: 42.0,),
      ),
    );

    final drawerItems = ListView(
        children: <Widget>[
          drawerHeader,
          ListTile(
            title: Text('Page1'),
            onTap: () {

            },
          ),
          ListTile(
            title: Text('Page2'),
            onTap: () {

            },
          ),
          ListTile(
            title: Text('Page3'),
            onTap: () {

            },
          )
        ]
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(_homePageTitle),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: Text('Выйти'),
                    value: 0,
                )
              ];
            },
            onSelected: (result) {
              if (result == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {

                },
                child: Text('Кнопка'),
            )
          ],
        )
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}
