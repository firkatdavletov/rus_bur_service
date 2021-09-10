import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/pages/users_page.dart';
import 'package:rus_bur_service/widgets/button.dart';

import '../main.dart';
import '../model.dart';
import 'create_report.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

_getListOfDogs() async {
  List<Dog> dogs = await db.dogs();
  //final List<String> dogNames = dogs.map((dog) => dog.id.toString()).toList();
  return dogs;
}

_getListOfReports() async {
  List<Report> reports = await db.reports();
  return reports;
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    String _login = context.watch<UserNotifier>().login;

    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height - mediaQuery.viewInsets.bottom;
    final screenWidth = mediaQuery.size.width;

    final drawerItems = ListView(
      children: [
        UserAccountsDrawerHeader(
            accountName: Text(_login),
            accountEmail: Text('accountEmail'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.yellow,
            child: Text(_login[0].toUpperCase()),
          ),
        ),
        Visibility(
            child: ListTile(
              title: Text(
                'Добавить пользователя',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UsersPage()
                  ),
                );
              },
            ),
            visible: _login == 'admin',
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


    double buttonVertPadding = _limit(screenWidth/100, 30);
    double buttonHorPadding = _limit(screenWidth/19, 200);
    double buttonFontSize = _limit(screenWidth/45, 30);


    return Scaffold(
      appBar: AppBar(
        title: Text(_login),
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
      body: FutureBuilder(
      future: _getListOfReports(),
      builder:
        (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data[index].toString());
                });
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
              return Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              );
            }
          },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateReport()
              )
            );
          },
          child: Icon(Icons.add))
    );
  }
  double _limit(double value, double limit) {
    if (value <= limit) {
      return value;
    } else {
      return limit;
    }
  }
}
