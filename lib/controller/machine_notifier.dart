import 'package:flutter/material.dart';

class MachineNotifier with ChangeNotifier {
  String _model = '';
  String _serialNumb = '';
  String _year = '';
  String _engineModel = '';
  String _engineSN = '';
  String _opTime = '';
  String _opTimeUnit = 'м/ч';

  String get model => _model;
  String get serialNumb => _serialNumb;
  String get year => _year;
  String get engineModel => _engineModel;
  String get engineSN => _engineSN;
  String get opTime => _opTime;
  String get opTimeUnit => _opTimeUnit;

  changeModel (String textController) {
    _model = textController;
    notifyListeners();
  }

  void changeSerialNumb (String textController) {
    _serialNumb = textController;
    notifyListeners();
  }

  void changeYear (String textController) {
    _year = textController;
    notifyListeners();
  }

  void changeEngineModel (String textController) {
    _engineModel = textController;
    notifyListeners();
  }

  void changeEngineSN (String textController) {
    _engineSN = textController;
    notifyListeners();
  }

  void changeOpTime (String textController) {
    _opTime = textController;
    notifyListeners();
  }

  void changeOpTimeUnit (String textController) {
    _opTimeUnit = textController;
    notifyListeners();
  }
}