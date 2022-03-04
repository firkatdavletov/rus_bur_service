import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/users_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';
import 'package:rus_bur_service/helpers/password_provider.dart';
import 'package:rus_bur_service/widgets/forms/app_text_form_field.dart';
import 'package:rus_bur_service/widgets/forms/password_field.dart';

import '../../controller/user_notifier.dart';
import '../../main.dart';

class UserEditAlertDialog extends StatefulWidget {
  final User user;
  const UserEditAlertDialog({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  _UserEditAlertDialogState createState() => _UserEditAlertDialogState();
}

class _UserEditAlertDialogState extends State<UserEditAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _middleName = '';
  String _login = '';
  String _password = '';
  bool _isAdmin = false;
  bool _flag = true;
  _getPassword() {
    return PasswordProvider().getPassword(widget.user.login);
  }
  bool _checkBoxValue = false;
  @override
  Widget build(BuildContext context) {

    if (_flag) {
      _checkBoxValue = widget.user.isAdmin;
      _flag = false;
      _isAdmin = widget.user.isAdmin;
    } else {
      _checkBoxValue = _isAdmin;
    }
    return SingleChildScrollView(
      child: Container(
        width: 350.0,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('ID: ${widget.user.userId}'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: AppTextFormFieldWithInitWithoutIcon(
                      helperText: 'Имя',
                      initialValue: widget.user.firstName,
                      onSaved: (String value) {
                        _firstName = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, заполните поле';
                        }
                      }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: AppTextFormFieldWithInitWithoutIcon(
                      helperText: 'Фамилия',
                      initialValue: widget.user.lastName,
                      onSaved: (String value) {
                        _lastName = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, заполните поле';
                        }
                      },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: AppTextFormFieldWithInitWithoutIcon(
                      helperText: 'Отчество',
                      initialValue: widget.user.middleName,
                      onSaved: (String value) {
                        _middleName = value;
                      },
                      validator: (String value) {
                        if (false) {
                          return 'Пожалуйста, заполните поле';
                        }
                      },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: AppTextFormFieldWithInit(
                      helperText: 'Логин',
                      initialValue: widget.user.login,
                      onSaved: (String value) {
                        _login = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, заполните поле';
                        }
                      },
                      icon: Icon(Icons.login_rounded),
                      label: ''
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: FutureBuilder(
                    future: _getPassword(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        _password = snapshot.data;
                        return Container(
                          //height: 500.0,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                                child: PasswordFieldWithInit(
                                    enabled: true,
                                    onSaved: (String value) {
                                      _password = value;
                                    },
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Заполните поле';
                                      }
                                    },
                                    icon: Icon(Icons.password),
                                    label: '',
                                    initialValue: _password
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return ErrorPage();
                      } else {
                        return WaitingPage();
                      }
                    },
                  ),
                ),
                Padding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: _checkBoxValue,
                          onChanged: (value) {
                            setState(() {
                              _isAdmin = value!;
                            });

                          }),
                      Text('Администратор')
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                User _user = User(
                                    firstName: _firstName,
                                    lastName: _lastName,
                                    middleName: _middleName,
                                    login: _login,
                                    userId: widget.user.userId,
                                    isAdmin: _isAdmin,
                                    isSuperAdmin: false
                                );
                                db.upgradeUser(_user);
                                PasswordProvider().deletePassword(widget.user.login);
                                PasswordProvider().writePassword(_login, _password);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UsersPage()
                                    )
                                );
                              }
                            },
                            child: Text('Сохранить')
                        )
                    ),
                    Visibility(
                        visible: widget.user.userId != Provider.of<UserNotifier>(context, listen: false).user.userId,
                        child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton(
                            onPressed: (){
                              db.deleteUser(widget.user.userId);
                              PasswordProvider().deletePassword(widget.user.login);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UsersPage()
                                  )
                              );
                            },
                            child: Text('Удалить')
                        )
                    )
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('Отмена')
                        )
                    ),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}

