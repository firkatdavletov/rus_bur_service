import 'package:flutter/material.dart';

class SpareNotifier with ChangeNotifier {
  String _number = '';
  int _quantity = 0;
  String _name = '';
  String _measure = '';
  String _issue = '';

  String get number => _number;
  int get quantity => _quantity;
  String get name => _name;
  String get measure => _measure;
  String get issue => _issue;

  changeNumber (String textController) {
    _number = textController;
    notifyListeners();
  }
  changeQuantity (int intController) {
    _quantity = intController;
    notifyListeners();
  }
  changeName (String textController) {
    _name = textController;
    notifyListeners();
  }
  changeMeasure (String textController) {
    _measure = textController;
    notifyListeners();
  }
  changeIssue (String textController) {
    _issue = textController;
    notifyListeners();
  }

  changePriority(String textController) {

  }
}
