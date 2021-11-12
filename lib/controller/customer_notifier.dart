import 'package:flutter/material.dart';

class CustomerNotifier with ChangeNotifier {
  String _companyName = '';
  String _customerFirstName = '';
  String _customerLastName = '';
  String _customerMiddleName = '';
  String _customerPhone = '';
  String _customerEmail = '';
  String _place = '';

  String get companyName => _companyName;
  String get customerFirstName => _customerFirstName;
  String get customerLastName => _customerLastName;
  String get customerMiddleName => _customerMiddleName;
  String get customerPhone => _customerPhone;
  String get customerEmail => _customerEmail;
  String get place => _place;

  changeCompanyName(String textController) {
    _companyName = textController;
    notifyListeners();
  }

  changePlace(String textController) {
    _place = textController;
    notifyListeners();
  }

  changeFirstName(String textController) {
    _customerFirstName = textController;
    notifyListeners();
  }

  changeLastName(String textController) {
    _customerLastName = textController;
    notifyListeners();
  }

  changeMiddleName(String textController) {
    _customerMiddleName = textController;
    notifyListeners();
  }

  changePhone(String textController) {
    _customerPhone = textController;
    notifyListeners();
  }

  changeEmail(String textController) {
    _customerEmail = textController;
    notifyListeners();
  }
}