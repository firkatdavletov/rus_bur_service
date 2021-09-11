import 'package:flutter/material.dart';

class UserNotifier with ChangeNotifier {
  String _login = '';

  String get login => _login;

  void change(String textController) {
    _login = textController;
    notifyListeners();
  }
}
