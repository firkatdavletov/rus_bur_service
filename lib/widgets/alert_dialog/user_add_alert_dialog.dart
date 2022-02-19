import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/pages/users_page.dart';
import 'package:rus_bur_service/helpers/password_provider.dart';
import 'package:rus_bur_service/widgets/forms/app_text_form_field.dart';
import 'package:rus_bur_service/widgets/forms/password_field.dart';

import '../../main.dart';

class UserAddAlertDialog extends StatefulWidget {
  const UserAddAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  _UserAddAlertDialogState createState() => _UserAddAlertDialogState();
}

class _UserAddAlertDialogState extends State<UserAddAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _middleName = '';
  String _login = '';
  String _password = '';
  bool _isAdmin = false;
  String _id = '';

  bool _userIdIsMatch = false;
  bool _userLoginIsMatch = false;

  @override
  Widget build(BuildContext context) {
    _findIdMatching(String id) {
      var users = db.getUsersMap('user_id', id);
      users.then((map) {
        if (map.length == 0) {
          _userIdIsMatch = false;
        } else {
          _userIdIsMatch = true;
        }
      });
    }
    _findLoginMatching(String login) {
      var users = db.getUsersMap('user_login', login);
      users.then((map) {
        if (map.length == 0) {
          _userLoginIsMatch = false;
        } else {
          _userLoginIsMatch = true;
        }
      });
    }
    return SingleChildScrollView(
      child: Container(
        width: 350.0,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: AppTextFormFieldWithoutIcon(
                      helperText: '',
                      onChanged: (String value) {
                        _firstName = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, заполните поле';
                        }
                      },
                      label: 'Имя'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: AppTextFormFieldWithoutIcon(
                      helperText: '',
                      onChanged: (String value) {
                        _lastName = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, заполните поле';
                        }
                      },
                      label: 'Фамилия'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: AppTextFormFieldWithoutIcon(
                      helperText: '',
                      onChanged: (String value) {
                        _middleName = value;
                      },
                      validator: (String value) {

                      },
                      label: 'Отчество'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: AppTextFormFieldWithoutIcon(
                      helperText: '',
                      onChanged: (String value) {
                        _id = value;
                        _findIdMatching(_id);
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, заполните поле';
                        } else if (_userIdIsMatch) {
                          return 'ID уже существует';
                        }
                      },
                      label: 'ID'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: AppTextFormFieldWithoutIcon(
                      helperText: '',
                      onChanged: (String value) {
                        _login = value;
                        _findLoginMatching(_login);
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, заполните поле';
                        } else if (_userLoginIsMatch) {
                          return 'Логин уже занят';
                        }
                      },
                      label: 'Логин'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: PasswordField(
                    onChanged: (String value) {
                      _password = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Заполните поле';
                      }
                    },
                    icon: Icon(Icons.password),
                    label: 'Пароль',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Администратор'),
                    Checkbox(
                        value: _isAdmin,
                        onChanged: (value) {
                          setState(() {
                            _isAdmin = value!;
                          });
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: OutlinedButton(
                            onPressed: (){
                              //_findLoginMatching(_login);
                              //_findIdMatching(_id);

                              if (_formKey.currentState!.validate()) {
                                User _user = User(
                                    firstName: _firstName,
                                    lastName: _lastName,
                                    middleName: _middleName,
                                    login: _login,
                                    userId: int.parse(_id),
                                    isAdmin: _isAdmin,
                                    isSuperAdmin: false
                                );
                                db.insertUser(_user);
                                PasswordProvider().writePassword(_login, _password);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UsersPage()
                                    )
                                );
                              }
                            },
                            child: Text('Создать')
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: OutlinedButton(
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

