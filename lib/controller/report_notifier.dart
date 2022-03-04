import 'package:flutter/material.dart';

import '../models/report.dart';

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
  int _opTime_1 = 0;
  int _opTime_2 = 0;
  int _opTime_3 = 0;
  int _opTime_4 = 0;
  String _note = '';

  int _lastId = 0;
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
  int get opTime_1 => _opTime_1;
  int get opTime_2 => _opTime_2;
  int get opTime_3 => _opTime_3;
  int get opTime_4 => _opTime_4;
  String get note => _note;

  int get lastId => _lastId;
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
  void changeOpTime_4(textController) {
    _opTime_4 = textController;
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

  void changeLastId (controller) {
    _lastId = controller;
    notifyListeners();
  }

  reset() {
    DateTime now = DateTime.now();

    changeName('');
    changeDate('${now.day}/${now.month}/${now.year}');
    changeCompany('');
    changePlace('');
    changeCustomerName('');
    changeCustomerPhone('');
    changeCustomerEmail('');
    changeMachineModel('');
    changeMachineNumb('');
    changeMachineYear('');
    changeEngineModel('');
    changeEngineNumb('');
    changeOpTime_1(0);
    changeOpTime_2(0);
    changeOpTime_3(0);
    changeOpTime_4(0);
    changeNote('');
    changeReportState(true);
  }

  set(Report report) {
    changeReportState(false);
    changeName(report.name);
    changeReportId(report.id);
    changeUserId(report.userId);
    changeCompany(report.company);
    changeDate(report.date);
    changePlace(report.place);
    changeCustomerName(report.customerName);
    changeCustomerPhone(report.customerPhone);
    changeCustomerEmail(report.customerEmail);
    changeMachineModel(report.machineModel);
    changeMachineNumb(report.machineNumb);
    changeMachineYear(report.machineYear);
    changeEngineModel(report.engineModel);
    changeEngineNumb(report.engineNumb);
    changeOpTime_1(report.opTime_1);
    changeOpTime_2(report.opTime_2);
    changeOpTime_3(report.opTime_3);
    changeOpTime_4(report.opTime_4);
    changeNote(report.note);
  }

  Map<String, dynamic> toMap() {
    return {
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
      'engine_optime_3' : opTime_3,
      'engine_optime_4' : opTime_4
    };
  }
}