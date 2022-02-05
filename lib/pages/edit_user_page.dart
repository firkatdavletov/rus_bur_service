import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/pages/users_page.dart';
import 'package:rus_bur_service/widgets/forms/text_form_field_edit_user.dart';

import '../main.dart';
import '../helpers/password_provider.dart';

class EditUser extends StatefulWidget {

  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  final TextEditingController _inputUserLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int _id = context.watch<UserNotifier>().user.userId;

    _getUser() async {
      Future<User> _user = db.readUser('user_id', '_id');
      return _user;
    }

    _upgradeUser(User user) async {
      db.upgradeUser(user);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UsersPage()
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit user'),
      ),
      body: FutureBuilder(
        future: _getUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
         if(snapshot.hasData) {
           PasswordProvider passwordProvider = PasswordProvider();
           final TextEditingController _inputUserFirstName = TextEditingController(text: snapshot.data.firstName);
           final TextEditingController _inputUserLastName = TextEditingController(text: snapshot.data.lastName);
           final TextEditingController _inputUserMiddleName = TextEditingController(text: snapshot.data.middleName);
           return Container(
             padding: EdgeInsets.all(20.0),
             child: Column(
               children: [
                 Text('Редактирование пользователя'),
                 EditUserTextField(
                   textEditingController: _inputUserFirstName,
                   // initialValue: snapshot.data.firstName,
                   labelText: 'Name',
                 ),
                 EditUserTextField(
                   textEditingController: _inputUserLastName,
                   // initialValue: snapshot.data.lastName,
                   labelText: 'Last name',
                 ),
                 EditUserTextField(
                   textEditingController: _inputUserMiddleName,
                   // initialValue: snapshot.data.middleName,
                   labelText: 'Middle name',
                 ),
                 Text('${snapshot.data.userId}'),
                 EditUserTextField(
                     textEditingController: _inputUserLogin,
                     // initialValue: snapshot.data.login,
                     labelText: 'Login'
                 ),
                 // PasswordTextField(
                 //     textController: _inputUserPassword,
                 //     labelText: 'Password'
                 // ),
                 Row(
                   children: [
                     ElevatedButton(
                         onPressed: () {
                           db.deleteUser(_id);
                           passwordProvider.deletePassword(snapshot.data.login);
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => UsersPage()
                             ),
                           );
                         },
                         child: Text('Delete')),
                     ElevatedButton(
                         onPressed: () async {
                           User user = await snapshot.data;
                           int id = user.userId;
                           String firstName = _inputUserFirstName.text;
                           String lastName = _inputUserLastName.text;
                           String middleName = _inputUserMiddleName.text;
                           String login = user.login;

                           user = User(
                               firstName: firstName,
                               lastName: lastName,
                               middleName: middleName,
                               login: login,
                               userId: id,
                               isAdmin: false
                           );
                           print('result: ${_upgradeUser(user)}');
                         },
                         child: Text('Upgrade')
                     )
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
