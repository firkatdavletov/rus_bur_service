import 'package:flutter/material.dart';

class DiagnosticCardsNotifier with ChangeNotifier {
  String _id = '';
  String _name = '';
  int _operationId = 0;
  int _reportId = 0;
  int _conclusion = 1;
  String _description = '';
  String _part = '';
  String _area = '';
  String _damage = '';
  int _priority = 1;
  String _recommend = '';
  int _termWeek = 0;
  int _term_mh = 0;
  int _term_bh = 0;
  int _term_m = 0;
  String _effect = '';
  int _manHours = 0;
  int _status = 0;

  String get id => _id;
  String get name => _name;
  int get operationId => _operationId;
  int get reportId => _reportId;
  int get conclusion => _conclusion;
  String get description => _description;
  String get part => _part;
  String get area => _area;
  String get damage => _damage;
  int get priority => _priority;
  String get recommend => _recommend;
  int get termWeek => _termWeek;
  int get term_mh => _term_mh;
  int get term_bh => _term_bh;
  int get term_m => _term_m;
  String get effect => _effect;
  int get manHours => _manHours;
  int get status => _status;

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
  changePart(String textController) {
    _part = textController;
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
  changeTermWeek(int textController) {
    _termWeek = textController;
    notifyListeners();
  }
  changeTerm_mh(int textController) {
    _term_mh = textController;
    notifyListeners();
  }
  changeTerm_bh(int textController) {
    _term_bh = textController;
    notifyListeners();
  }
  changeTerm_m(int textController) {
    _term_m = textController;
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
  changeStatus(int textController) {
    _status = textController;
    notifyListeners();
  }
}