import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/home_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';
import 'package:rus_bur_service/helpers/password_provider.dart';
import 'package:rus_bur_service/widgets/forms/password_field.dart';

import '../../main.dart';
import 'app_text_form_field.dart';
import '../buttons/app_outlined_button.dart';


class AuthorizationForm extends StatefulWidget {
  const AuthorizationForm({Key? key}) : super(key: key);

  @override
  _AuthorizationFormState createState() => _AuthorizationFormState();
}

class _AuthorizationFormState extends State<AuthorizationForm> {
  final _formKey = GlobalKey<FormState>();
  _getUser () async {
    User _user = await db.readUserByLogin(_login);
    context.read<UserNotifier>().changeUser(_user);
    return _user;
  }
  _getKey(String key) async {
    return PasswordProvider().getPassword(key);
  }

  String _login = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {

    _validatorName(String value) {
      if (value.isEmpty) {
        return 'Пожалуйста, заполните поле';
      }
      return null;
    }

    _error() {
      return null;
    }

    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: AppTextFormField(
                helperText: '',
                onChanged: (String value) {
                  setState(() {
                    _login = value;
                  });
                },
                validator: _validatorName,
                label: 'Логин',
                icon: Icon(Icons.person),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: PasswordField(
                onChanged: (String value) {
                  _password = value;
                },
                validator: _validatorName,
                label: 'Пароль',
                icon: Icon(Icons.password, color: Colors.black54),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                  child: FutureBuilder(
                    future: _getKey(_login),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      _auth() {
                        if(_formKey.currentState!.validate()) {
                          if (_password == snapshot.data) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Вы успешно авторизовались')));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FutureBuilder(
                                      future: _getUser(),
                                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasData) {
                                          return HomePage();
                                        } else if (snapshot.hasError) {
                                          return ErrorPage();
                                        } else {
                                          return WaitingPage();
                                        }
                                      },
                                    )
                                )
                            );
                          } else if (snapshot.data == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Неверный логин')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Неверный пароль')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, заполните все поля')));
                        }
                      }
                      if (snapshot.hasData) {
                        return AppOutLinedButton(submit: _auth, text: 'Вход в систему');
                      } else if (snapshot.hasError) {
                        return AppOutLinedButton(submit: _error, text: 'Ошибка');
                      } else {
                        return Container();
                      }
                    },
                  )
              ),
            )
          ],
        )
    );
  }
}
