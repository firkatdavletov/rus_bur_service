import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/pages/users_page.dart';

import '../main.dart';

class EditUser extends StatefulWidget {

  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {


  @override
  Widget build(BuildContext context) {
    int _id = context.watch<UserNotifier>().id;

    _getUser() async {
      Future<User> _user = db.readUser(_id);
      return _user;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit user'),
      ),
      body: FutureBuilder(
        future: _getUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
         if(snapshot.hasData) {
           return Container(
             padding: EdgeInsets.all(20.0),
             child: Column(
               children: [
                 Text('Редактирование пользователя'),
                 Text('User Id: ${snapshot.data.userId}'),
                 Text('User name : ${snapshot.data.firstName}'),
                 Text('User lastname: ${snapshot.data.lastName}'),
                 Text('User middlename: ${snapshot.data.middleName}'),
                 Row(
                   children: [
                     ElevatedButton(
                         onPressed: () {
                           db.deleteUser(_id);
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => UsersPage()
                             ),
                           );
                         },
                         child: Text('Delete')),
                   ],
                 )
               ],
             ),
           );
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
    );
  }
}
