import 'package:flutter/material.dart';

class PartNotifier with ChangeNotifier {
  int _id = 0;
  String _name = '';

  int get id => _id;
  String get name => _name;

  changeId (intController) {
    _id = intController;
    notifyListeners();
  }

  changeName (textController) {
    _name = textController;
    notifyListeners();
  }
}