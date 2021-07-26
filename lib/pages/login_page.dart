import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:rus_bur_service/db.dart';

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
  String _loginInput = '';
  String _passwordInput = '';
  String admin = 'admin';
  String adminPass = '123';

  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
              controller: _login,
            ),
          ),
          new Container(
            child: new TextField(
              decoration: new InputDecoration(
                  labelText: _passwordFieldLabel
              ),
              controller: _password,
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
          _loginInput = _login.text;
          _passwordInput = _password.text;
          if (_loginInput == admin && _passwordInput == adminPass) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
        child: Text(_loginButtonText),
      ),
    );
  }
}
