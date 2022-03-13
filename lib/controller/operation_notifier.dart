import 'package:flutter/material.dart';

import '../models/operation.dart';

class OperationNotifier with ChangeNotifier {
  int _id = 0;
  int _partId = 0;
  String _name = '';
  bool _isRequired = false;

  int get id => _id;
  int get partId => _partId;
  String get name => _name;
  bool get isRequired => _isRequired;

  changeId (intController) {
    _id = intController;
    notifyListeners();
  }

  changePartId (intController) {
    _partId = intController;
    notifyListeners();
  }

  changeName (textController) {
    _name = textController;
    notifyListeners();
  }

  changeIsRequired (boolController) {
    _isRequired = boolController;
    notifyListeners();
  }

  emptyOperation(int partId) {
    _id = 0;
    _partId = partId;
    _name = '';
    _isRequired = false;
    notifyListeners();
  }

  setOperation(Operation op) {
    _id = op.id;
    _partId = op.partId;
    _name = op.name;
    _isRequired = op.isRequired;
    notifyListeners();
  }
}