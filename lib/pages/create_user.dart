import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/pages/users_page.dart';
import 'package:rus_bur_service/widgets/forms/password_field.dart';
import 'package:rus_bur_service/widgets/forms/text_form_field_edit_user.dart';

import '../main.dart';
import '../helpers/password_provider.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _inputUserFirstName = TextEditingController();
  final TextEditingController _inputUserLastName = TextEditingController();
  final TextEditingController _inputUserMiddleName = TextEditingController();
  final TextEditingController _inputLogin = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Container(
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
            EditUserTextField(
              textEditingController: _inputLogin,
              // initialValue: snapshot.data.middleName,
              labelText: 'Login',
            ),
            // PasswordTextField(
            //   textController: _inputPassword,
            //   labelText: 'Password'
            // ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      PasswordProvider passwordProvider = PasswordProvider();
                      User user = User(
                          firstName: _inputUserFirstName.text,
                          lastName: _inputUserLastName.text,
                          middleName: _inputUserMiddleName.text,
                          login: _inputLogin.text,
                          userId: 0,
                          isAdmin: false
                      );
                      db.insertUser(user);
                      passwordProvider.writePassword(user.login, _inputPassword.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UsersPage()
                        ),
                      );
                    },
                    child: Text('Insert')),
              ],
            )
          ],
        ),
      )
    );
  }
}
