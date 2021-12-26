import 'package:flutter/material.dart';

class EmailMessageNotifier with ChangeNotifier {
  String _recipients = 'dr.firkat@ya.ru';
  String _subject = 'Тема сообщения';
  String _text = 'Текст сообщения';

  String get recipients => _recipients;
  String get subject => _subject;
  String get text => _text;

  changeRecipients (textController) {
    _recipients = textController;
    notifyListeners();
  }

  changeSubject (textController) {
    _subject = textController;
    notifyListeners();
  }

  changeText (textController) {
    _text = textController;
    notifyListeners();
  }
}