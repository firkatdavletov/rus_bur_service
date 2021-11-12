import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';

import 'package:rus_bur_service/pages/home_page.dart';
import 'package:rus_bur_service/pages/machine_info_page.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'app_text_form_field.dart';

class CreateReportForm extends StatefulWidget {
  const CreateReportForm({Key? key}) : super(key: key);

  @override
  _CreateReportFormState createState() => _CreateReportFormState();
}

class _CreateReportFormState extends State<CreateReportForm> {
  final _formKey_1 = GlobalKey<FormState>();

  _validate(String value) {
      if (value.isEmpty) {
        return 'Пожалуйста, заполните поле';
      }
  }

  _getReportsCount(int userId) async {
    print('user id in _getReportsCount function: $userId');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? mainCounter = (prefs.getInt('main_counter') ?? 0) + 1;
    print('main counter: $mainCounter');
    await prefs.setInt('main_counter', mainCounter);

    int? separateCounter = (prefs.getInt('counter_$userId') ?? 0) + 1;
    await prefs.setInt('counter_$userId', separateCounter);

    return {
      'mainCount': mainCounter,
      'userCount' : separateCounter
    };
  }

  @override
  Widget build(BuildContext context) {
    bool _enable = true;

    _writeReportIdAndName() async {
      var _map = _getReportsCount(Provider.of<UserNotifier>(context, listen: false).user.userId);
      _map.then((map) {
        context.read<ReportNotifier>().changeReportId(map['mainCount']);
        String _name = '${Provider.of<UserNotifier>(context, listen: false).user.userId}-${map['userCount']}';
        context.read<ReportNotifier>().changeName(_name);
        context.read<ReportNotifier>().changeUserId(
            Provider.of<UserNotifier>(context, listen: false).user.userId);
        db.insertReport_2(context);
        _enable = false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()
            )
        );
      });
    }
    return Column(
      children: [
        Form(
            key: _formKey_1,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInit(
                    initialValue: context.watch<ReportNotifier>().company,
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeCompany(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.circle, color: Colors.green,),
                    label: 'Заказчик',
                    helperText: 'Наименование юридического лица',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInit(
                    initialValue: context.watch<ReportNotifier>().date,
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeDate(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.calendar_today),
                    label: 'Дата осмотра',
                    helperText: 'ДД/ММ/ГГГГ',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInit(
                    initialValue: context.watch<ReportNotifier>().place,
                    onSaved: (value) {
                      context.read<ReportNotifier>().changePlace(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.map),
                    label: 'Место проведения',
                    helperText: 'Населенный пункт',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInit(
                    initialValue: context.watch<ReportNotifier>().customerName,
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeCustomerName(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.person),
                    label: 'Контактное лицо заказчика',
                    helperText: 'ФИО',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInit(
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeCustomerPhone(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.phone),
                    label: 'Контактный телефон',
                    initialValue: context.watch<ReportNotifier>().customerPhone,
                    helperText: '',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInit(
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeCustomerEmail(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.email),
                    label: 'Email',
                    initialValue: context.watch<ReportNotifier>().customerEmail,
                    helperText: '',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: OutlinedButton (
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()
                                )
                            );
                          },
                          child: Text('Отмена')
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: OutlinedButton (
                          onPressed: () {
                            if (_formKey_1.currentState!.validate() && _enable) {
                              _formKey_1.currentState!.save();
                              if (Provider.of<ReportNotifier>(context, listen: false).isNewReport) {
                                _writeReportIdAndName();
                              } else {
                                db.upgradeReport_2(context);
                                _enable = false;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()
                                    )
                                );
                              }

                            }
                          },
                          child: Text('Сохранить')
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: OutlinedButton (
                          onPressed: () {
                            if (_formKey_1.currentState!.validate() && _enable) {
                              _formKey_1.currentState!.save();
                              if (Provider.of<ReportNotifier>(context, listen: false).isNewReport) {
                                _writeReportIdAndName();
                              } else {
                                db.upgradeReport_2(context);
                                _enable = false;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MachineInfoPage()
                                    )
                                );
                              }

                            }
                          },
                          child: Text('Далее')
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: TextButton(
                    child: Text('Очистить форму'),
                    onPressed: () {
                      context.read<ReportNotifier>().changeCompany('');
                      context.read<ReportNotifier>().changeDate('');
                      context.read<ReportNotifier>().changeCustomerPhone('');
                      context.read<ReportNotifier>().changeCustomerName('');
                      context.read<ReportNotifier>().changeOpTime('');
                      context.read<ReportNotifier>().changeNote('');
                      context.read<ReportNotifier>().changePlace('');
                      context.read<ReportNotifier>().changeCustomerEmail('');
                      context.read<ReportNotifier>().changeEngineModel('');
                      context.read<ReportNotifier>().changeEngineNumb('');
                      context.read<ReportNotifier>().changeMachineNumb('');
                      context.read<ReportNotifier>().changeMachineModel('');
                      context.read<ReportNotifier>().changeMachineYear('');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportMainPage()
                          )
                      );
                    },
                  ),
                )
              ],
            )
        ),
      ],
    );
  }
}
