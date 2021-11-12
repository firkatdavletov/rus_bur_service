import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';

import 'package:rus_bur_service/pages/home_page.dart';
import 'package:rus_bur_service/pages/pictures_page.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'app_text_form_field.dart';

class MachineInfoForm extends StatefulWidget {
  const MachineInfoForm({Key? key}) : super(key: key);

  @override
  _MachineInfoFormState createState() => _MachineInfoFormState();
}

class _MachineInfoFormState extends State<MachineInfoForm> {
  final _formKey_1 = GlobalKey<FormState>();
  final _formKey_2 = GlobalKey<FormState>();

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
                    initialValue: context.watch<ReportNotifier>().machineModel,
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeMachineModel(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right, color: Colors.black26,),
                    label: 'Модель машины',
                    helperText: '',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInit(
                    initialValue: context.watch<ReportNotifier>().machineNumb,
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeMachineNumb(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right),
                    label: 'Серийный номер машины',
                    helperText: '',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInit(
                    initialValue: context.watch<ReportNotifier>().machineYear,
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeMachineYear(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right),
                    label: 'Год выпуска',
                    helperText: '',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInit(
                    initialValue: context.watch<ReportNotifier>().engineModel,
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeEngineModel(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right),
                    label: 'Модель двигателя',
                    helperText: '',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInit(
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeEngineNumb(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right),
                    label: 'Серийный номер двигателя',
                    initialValue: context.watch<ReportNotifier>().engineNumb,
                    helperText: '',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInitSuffix(
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeOpTime(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right),
                    label: 'Наработка (м/ч)',
                    initialValue: context.watch<ReportNotifier>().opTime,
                    helperText: '',
                    suffixText: 'м/ч',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInitSuffix(
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeOpTime(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right),
                    label: 'Наработка (уд/ч)',
                    initialValue: context.watch<ReportNotifier>().opTime,
                    helperText: '',
                    suffixText: 'уд/ч',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInitSuffix(
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeOpTime(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right),
                    label: 'Наработка (пог/м)',
                    initialValue: context.watch<ReportNotifier>().opTime,
                    helperText: '',
                    suffixText: 'пог/м',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInitMaxLines(
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeNote(value);
                    },
                    validator: _validate,
                    maxLines: 5,
                    icon: Icon(Icons.arrow_right),
                    label: 'Примечание',
                    initialValue: context.watch<ReportNotifier>().note,
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
                                    builder: (context) => ReportMainPage()
                                )
                            );
                          },
                          child: Text('Назад')
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: OutlinedButton (
                          onPressed: () {
                            if (_formKey_1.currentState!.validate() && _enable) {
                              _formKey_1.currentState!.save();
                              // Report report = Report(
                              //   id: Provider.of<ReportNotifier>(context, listen: false).id,
                              //   userId: Provider.of<ReportNotifier>(context, listen: false).userId,
                              //   name: Provider.of<ReportNotifier>(context, listen: false).name,
                              //   date: Provider.of<ReportNotifier>(context, listen: false).date,
                              //   company: Provider.of<ReportNotifier>(context, listen: false).company,
                              //   place: Provider.of<ReportNotifier>(context, listen: false).place,
                              //   customerName: Provider.of<ReportNotifier>(context, listen: false).customerName,
                              //   customerPhone: Provider.of<ReportNotifier>(context, listen: false).customerPhone,
                              //   customerEmail: Provider.of<ReportNotifier>(context, listen: false).customerEmail,
                              //   machineModel: 'model',//Provider.of<ReportNotifier>(context, listen: false).machineModel,
                              //   machineNumb: 'sn',//Provider.of<ReportNotifier>(context, listen: false).machineNumb,
                              //   machineYear: 'year',//,Provider.of<ReportNotifier>(context, listen: false).machineYear,
                              //   engineModel: 'model',//Provider.of<ReportNotifier>(context, listen: false).engineModel,
                              //   engineNumb: 'numb',//Provider.of<ReportNotifier>(context, listen: false).engineNumb,
                              //   opTime: 'time',//Provider.of<ReportNotifier>(context, listen: false).opTime,
                              //   note: 'note',//Provider.of<ReportNotifier>(context, listen: false).note,
                              // );
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PicturesPage()
                                )
                            );
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
