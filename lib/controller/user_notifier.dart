import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';

class UserNotifier with ChangeNotifier {
  User _user = User(
    login: '',
    lastName: '',
    middleName: '',
    isAdmin: false,
    firstName: '',
    userId: 0,
  );

  User get user => _user;

  void changeUser(User userController) {
    _user = userController;
    notifyListeners();
  }
}
