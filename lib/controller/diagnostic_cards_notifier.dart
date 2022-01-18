import 'package:flutter/material.dart';

class DiagnosticCardsNotifier with ChangeNotifier {
  String _id = '';
  String _name = '';
  int _operationId = 0;
  int _reportId = 0;
  int _conclusion = 1;
  String _description = '';
  String _area = '';
  String _damage = '';
  int _priority = 1;
  String _recommend = '';
  String _time = '';
  String _effect = '';
  int _manHours = 0;

  String get id => _id;
  String get name => _name;
  int get operationId => _operationId;
  int get reportId => _reportId;
  int get conclusion => _conclusion;
  String get description => _description;
  String get area => _area;
  String get damage => _damage;
  int get priority => _priority;
  String get recommend => _recommend;
  String get time => _time;
  String get effect => _effect;
  int get manHours => _manHours;

  changeId(String textController) {
    _id = textController;
    notifyListeners();
  }
  changeName(String textController) {
    _name = textController;
    notifyListeners();
  }
  changeOperationId(int textController) {
    _operationId = textController;
    notifyListeners();
  }
  changeReportId(int textController) {
    _reportId = textController;
    notifyListeners();
  }
  changeConclusion(int textController) {
    _conclusion = textController;
    notifyListeners();
  }
  changeDescription(String textController) {
    _description = textController;
    notifyListeners();
  }
  changeArea(String textController) {
    _area = textController;
    notifyListeners();
  }
  changeDamage(String textController) {
    _damage = textController;
    notifyListeners();
  }
  changePriority(int textController) {
    _priority = textController;
    notifyListeners();
  }
  changeRecommend(String textController) {
    _recommend = textController;
    notifyListeners();
  }
  changeTime(String textController) {
    _time = textController;
    notifyListeners();
  }
  changeEffect(String textController) {
    _effect = textController;
    notifyListeners();
  }
  changeManHours(int textController) {
    _manHours = textController;
    notifyListeners();
  }
}