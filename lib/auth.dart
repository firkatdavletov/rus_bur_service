import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/pages/home_page.dart';

class AppAuth {
  final String login;
  final String password;
  final BuildContext context;

  AppAuth({
    required this.login,
    required this.password,
    required this.context
  });

  void auth() async {
    final _storage = new FlutterSecureStorage();

    String? _temp = await _storage.read(key: login);

    await _storage.write(key: 'admin', value: '123');

    if (_temp == password) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()
        ),
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

