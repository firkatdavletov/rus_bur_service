import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';
import 'package:rus_bur_service/widgets/alert_dialog/user_edit_alert_dialog.dart';

import '../../main.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({Key? key}) : super(key: key);
  _getUsersList() async {
    List<User> _users = await db.users();
    return _users;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUsersList(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int i) {
                return ListTile(
                  title: Text('${snapshot.data[i].firstName} ${snapshot.data[i].lastName}'),
                  subtitle: Text('${snapshot.data[i].login}'),
                  leading: Text('${snapshot.data[i].userId}'),
                  trailing: snapshot.data[i].isAdmin? Text('Администратор') : Text('Пользователь'),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Редактирование пользователя'),
                            content: UserEditAlertDialog(user: snapshot.data[i],),
                          );
                        });
                  },
                );
              }
          );
        } else if (snapshot.hasData) {
          return ErrorPage();
        } else {
          return WaitingPage();
        }
      },
    );
  }
}
