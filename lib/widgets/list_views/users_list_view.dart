import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';
import 'package:rus_bur_service/widgets/alert_dialog/user_edit_alert_dialog.dart';

import '../../controller/user_notifier.dart';
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
                String userStatus = snapshot.data[i].isSuperAdmin
                    ? 'Супер администратор'
                    : snapshot.data[i].isAdmin
                    ? 'Администратор'
                    : 'Пользователь';
                return ListTile(
                  title: Text('${snapshot.data[i].firstName} ${snapshot.data[i].lastName}'),
                  subtitle: Text('${snapshot.data[i].login}'),
                  leading: Text('${snapshot.data[i].userId}'),
                  trailing: Text(userStatus),
                  onTap: () {
                    bool isSuperAdmin = Provider.of<UserNotifier>(context, listen: false).isSuperAdmin;
                    if (!snapshot.data[i].isSuperAdmin || isSuperAdmin) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Редактирование пользователя', textAlign: TextAlign.center,),
                              content: UserEditAlertDialog(user: snapshot.data[i],),
                            );
                          });
                    }
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
