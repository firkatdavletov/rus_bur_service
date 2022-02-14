import 'package:flutter/material.dart';
import 'package:rus_bur_service/helpers/app_shared_preferance.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/pages/login_page.dart';
import 'package:rus_bur_service/helpers/password_provider.dart';
import 'package:rus_bur_service/widgets/forms/password_field.dart';

import '../../main.dart';
import 'app_text_form_field.dart';
import '../buttons/app_outlined_button.dart';


class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _middleName = '';
  String _login = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    _saveName(String value) {
      _firstName = value;
    }

    _saveLastName(String value) {
      _lastName = value;
    }

    _saveMiddleName(String value) {
      _middleName = value;
    }

    _saveLogin(String value) {
      _login = value;
    }
    _savePassword(String value) {
      _password = value;
    }

    _validatorName(String value) {
      if (value.isEmpty) {
        return 'Пожалуйста, заполните поле';
      }
      return null;
    }

    _submitForm() {
      if(_formKey.currentState!.validate()) {
        User _user = User(
          firstName: _firstName,
          lastName: _lastName,
          middleName: _middleName,
          login: _login,
          userId: 1,
          isAdmin: true,
          isSuperAdmin: true
        );
        db.insertUser(_user);
        PasswordProvider().writePassword('rbs_key', 'rbs_key');
        PasswordProvider().writePassword(_login, _password);

        var _prefs = AppSharedPref();
        _prefs.initPrefs();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage()
            )
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Вы успешно зарегистрированы')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, заполните все поля')));
      }
    }

    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: AppTextFormField(
                helperText: '',
                onChanged: _saveName,
                validator: _validatorName,
                label: 'Имя',
                icon: Icon(Icons.person, color: Colors.black54,),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: AppTextFormField(
                helperText: '',
                onChanged: _saveLastName,
                validator: _validatorName,
                label: 'Фамилия',
                icon: Icon(Icons.person, color: Colors.black54),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: AppTextFormField(
                helperText: '',
                onChanged: _saveMiddleName,
                validator: (value) {},
                label: 'Отчество (не обязательно)',
                icon: Icon(Icons.person, color: Colors.black54),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: AppTextFormField(
                helperText: '',
                onChanged: _saveLogin,
                validator: _validatorName,
                label: 'Логин',
                icon: Icon(Icons.person),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: PasswordField(
                onChanged: _savePassword,
                validator: _validatorName,
                label: 'Пароль',
                icon: Icon(Icons.password, color: Colors.black54),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                  child: AppOutLinedButton(submit: _submitForm, text: 'Регистрация',)
              ),
            )
          ],
        )
    );
  }
}
