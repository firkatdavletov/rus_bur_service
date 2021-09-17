import 'package:flutter/material.dart';

class UserNotifier with ChangeNotifier {
  String _login = '';
  int _id = 0;

  String get login => _login;
  int get id => _id;

  void change(String textController) {
    _login = textController;
    notifyListeners();
  }

  void changeId(int cid) {
    _id = cid;
    notifyListeners();
  }
}
