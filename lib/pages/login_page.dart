import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rus_bur_service/widgets/vertical_text.dart';
import 'package:rus_bur_service/widgets/logo.dart';

import 'home_page.dart';
import 'package:rus_bur_service/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _loginInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    final _buttonStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        padding: EdgeInsets.symmetric(vertical: 10)
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueGrey, Colors.lightBlueAccent]
          )
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    VerticalText(),
                    Logo(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _loginInput,
                      keyboardType: TextInputType.name,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person, color: Colors.white70,),
                        labelText: 'Введите имя пользователя',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                width: 2.0
                            )
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                width: 2.0
                            )
                        ),
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _passwordInput,
                      obscureText: _showPassword,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password, color: Colors.white70),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: this._showPassword ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() => this._showPassword = !this._showPassword);
                          },

                        ),
                        labelText: 'Введите пароль*',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                width: 2.0
                            )
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                width: 2.0
                            )
                        ),
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 200),
                  child: ElevatedButton(
                    style: _buttonStyle,
                    onPressed: () async {
                      final _storage = new FlutterSecureStorage();
                      User user = User(_loginInput.text, _passwordInput.text);

                      String? _temp = await _storage.read(key: user.login);
                      String? _myKey1 = await _storage.read(key: 'myKey1');

                      if (_myKey1 == null) {
                        await _storage.write(key: 'myKey1', value: 'myKey1');
                        await _storage.write(key: 'admin', value: '123');
                      }

                      if (_temp == user.password) {
                        _authUser(user);
                      } else if (_temp == null) {
                        _showSnack('Имя пользователя неверно');
                      } else {
                        _showSnack('Пароль неверный');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('ВОЙТИ В СИСТЕМУ'),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      )
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
