import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'home_page.dart';
import 'package:rus_bur_service/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _appBarTitle = 'РусБурСервис';
  String _loginButtonText = 'Войти';
  String _loginFieldLabel = 'Имя пользователя';
  String _passwordFieldLabel = 'Пароль';

  final TextEditingController loginInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: FlutterLogo(size: 20),
        title: Text(_appBarTitle),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              child: Image(
                image: AssetImage('assets/img/logo.png'),
              ),
            ),
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      )
    );
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              decoration: new InputDecoration(
                  labelText: _loginFieldLabel
              ),
              controller: loginInput,
            ),
          ),
          new Container(
            child: new TextField(
              decoration: new InputDecoration(
                  labelText: _passwordFieldLabel
              ),
              controller: passwordInput,
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          final _user = User(loginInput.text, passwordInput.text);
          _authUser(_user);
        },
        child: Text(_loginButtonText),
      ),
    );
  }

  Future _authUser(User user) async {
    final _storage = new FlutterSecureStorage();

    String? _temp = await _storage.read(key: user.login);
    String? _myKey1 = await _storage.read(key: 'myKey1');

    if (_myKey1 == null) {
      await _storage.write(key: 'myKey1', value: 'myKey1');
      await _storage.write(key: 'admin', value: '123');
    }

    if (_temp == user.password) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (_temp == null) {
      _showSnack('Имя пользователя неверно');
    } else {
      _showSnack('Пароль неверный');
    }
  }

  _showSnack (String text) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(milliseconds: 500),
      )
  );
}
