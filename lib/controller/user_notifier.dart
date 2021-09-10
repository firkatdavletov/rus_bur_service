import 'package:flutter/material.dart';

class UserNotifier with ChangeNotifier {
  String _login = '';

  String get login => _login;

  void change(String textController) {
    _login = textController;
    notifyListeners();
  }
}

class ScreenSize with ChangeNotifier {
  late MediaQueryData _mediaQueryData;

  MediaQueryData get mediaQueryData => _mediaQueryData;

  void change(MediaQueryData mediaQueryData) {
    _mediaQueryData = mediaQueryData;
    notifyListeners();
  }
}