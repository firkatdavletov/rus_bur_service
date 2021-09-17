import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/models/users_data_source.dart';
import 'package:rus_bur_service/pages/edit_user.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';

import '../main.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final tableColumns = <DataColumn>[
    DataColumn(label: Text('ID')),
    DataColumn(label: Text('Name'))
  ];

  @override
  Widget build(BuildContext context) {
    _getUsersList() async {
      List<User> _users = await db.users();
      return _users;
    }

    double _limit(double value, double limit) {
      if (value <= limit) {
        return value;
      } else {
        return limit;
      }
    }

    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height - mediaQuery.viewInsets.bottom;
    final screenWidth = mediaQuery.size.width;
    double textFontSize = _limit(screenWidth/20, 30);
    int _id = 0;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users page'
        ),
      ),
      body: FutureBuilder(
        future: _getUsersList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text(
                          snapshot.data[index].idToString(),
                          style: TextStyle(fontSize: textFontSize)),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text(
                            snapshot.data[index].nameToString(),
                            style: TextStyle(fontSize: textFontSize))
                      ),
                      Container(
                        child: Text(
                        snapshot.data[index].loginToString(),
                        style: TextStyle(fontSize: textFontSize))
                      ),
                      Container(
                        child: IconButton(
                            onPressed: () {
                              _id = snapshot.data[index].userId;
                              context.read<UserNotifier>().changeId(_id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditUser()
                                ),
                              );
                            },
                            icon: Icon(Icons.edit)
                        )
                      )
                    ],
                  );
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
          User user = User(
              userId: 0,
              login: 'firkat',
              firstName: 'Firkat',
              lastName: 'Davletov',
              middleName: 'Gazinurovich'
          );
          db.insertUser(user);
        },
      ),
    );
  }
}

