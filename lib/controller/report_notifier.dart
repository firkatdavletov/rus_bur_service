import 'package:flutter/material.dart';

class ReportNotifier with ChangeNotifier{
  int _id = 0;
  int _userId = 0;
  String _name = '';
  String _date = '';
  String _company = '';
  String _place = '';
  String _customerName = '';
  String _customerPhone = '';
  String _customerEmail = '';
  String _machineModel = '';
  String _machineNumb = '';
  String _machineYear = '';
  String _engineModel = '';
  String _engineNumb = '';
  String _opTime_1 = '';
  String _opTime_2 = '';
  String _opTime_3 = '';
  String _note = '';

  bool _isNewReport = false;

  int get userId => _userId;
  int get id => _id;
  String get name => _name;
  String get date => _date;
  String get company => _company;
  String get place => _place;
  String get customerName => _customerName;
  String get customerPhone => _customerPhone;
  String get customerEmail => _customerEmail;
  String get machineModel => _machineModel;
  String get machineNumb => _machineNumb;
  String get machineYear => _machineYear;
  String get engineModel => _engineModel;
  String get engineNumb => _engineNumb;
  String get opTime_1 => _opTime_1;
  String get opTime_2 => _opTime_2;
  String get opTime_3 => _opTime_3;
  String get note => _note;

  bool get isNewReport => _isNewReport;

  void changeUserId(int numb) {
    _userId = numb;
    notifyListeners();
  }
  void changeReportId(int numb) {
    _id = numb;
    notifyListeners();
  }
  void changeName(textController) {
    _name = textController;
    notifyListeners();
  }
  void changeDate(textController) {
    _date = textController;
    notifyListeners();
  }
  void changeCompany(textController) {
    _company = textController;
    notifyListeners();
  }
  void changePlace(textController) {
    _place = textController;
    notifyListeners();
  }
  void changeCustomerName(textController) {
    _customerName = textController;
    notifyListeners();
  }
  void changeCustomerPhone(textController) {
    _customerPhone = textController;
    notifyListeners();
  }
  void changeCustomerEmail(textController) {
    _customerEmail = textController;
    notifyListeners();
  }
  void changeMachineModel(textController) {
    _machineModel = textController;
    notifyListeners();
  }
  void changeMachineNumb(textController) {
    _machineNumb = textController;
    notifyListeners();
  }
  void changeMachineYear(textController) {
    _machineYear = textController;
    notifyListeners();
  }
  void changeEngineModel(textController) {
    _engineModel = textController;
    notifyListeners();
  }
  void changeEngineNumb(textController) {
    _engineNumb = textController;
    notifyListeners();
  }
  void changeOpTime_1(textController) {
    _opTime_1 = textController;
    notifyListeners();
  }
  void changeOpTime_2(textController) {
    _opTime_2 = textController;
    notifyListeners();
  }
  void changeOpTime_3(textController) {
    _opTime_3 = textController;
    notifyListeners();
  }
  void changeNote(textController) {
    _note = textController;
    notifyListeners();
  }

  void changeReportState(stateController) {
    _isNewReport = stateController;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'report_id' : id,
      'user_id' : userId,
      'report_name' : name,
      'report_date' : date,
      'customer_company' : company,
      'customer_name' : customerName,
      'customer_phone' : customerPhone,
      'customer_email' : customerEmail,
      'machine_model' : machineModel,
      'machine_sn' : machineNumb,
      'machine_year' : machineYear,
      'report_place' : place,
      'report_note' : note,
      'engine_model' : engineModel,
      'engine_sn' : engineNumb,
      'engine_optime_1' : opTime_1,
      'engine_optime_2' : opTime_2,
      'engine_optime_3' : opTime_1
    };
  }
}