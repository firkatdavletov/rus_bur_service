import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/pages/home_page.dart';
import 'package:rus_bur_service/pages/pictures_page.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';

import '../../main.dart';
import 'app_text_form_field.dart';

class MachineInfoForm extends StatefulWidget {
  const MachineInfoForm({Key? key}) : super(key: key);

  @override
  _MachineInfoFormState createState() => _MachineInfoFormState();
}

class _MachineInfoFormState extends State<MachineInfoForm> {
  final _formKey_1 = GlobalKey<FormState>();

  _validate(String value) {
    if (value.isEmpty) {
      return 'Пожалуйста, заполните поле';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      context.read<ReportNotifier>().changeOpTime_1(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right),
                    label: 'Наработка (м/ч)',
                    initialValue: context.watch<ReportNotifier>().opTime_1,
                    helperText: '',
                    suffixText: 'м/ч',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInitSuffix(
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeOpTime_2(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right),
                    label: 'Наработка (уд/ч)',
                    initialValue: context.watch<ReportNotifier>().opTime_2,
                    helperText: '',
                    suffixText: 'уд/ч',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: AppTextFormFieldWithInitSuffix(
                    onSaved: (value) {
                      context.read<ReportNotifier>().changeOpTime_3(value);
                    },
                    validator: _validate,
                    icon: Icon(Icons.arrow_right),
                    label: 'Наработка (пог/м)',
                    initialValue: context.watch<ReportNotifier>().opTime_3,
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
                            if (_formKey_1.currentState!.validate()) {
                              _formKey_1.currentState!.save();
                              db.upgradeReport_2(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()
                                  )
                              );
                            }
                          },
                          child: Text('Сохранить')
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: OutlinedButton (
                          onPressed: () {
                            if (_formKey_1.currentState!.validate()) {
                              _formKey_1.currentState!.save();
                              db.upgradeReport_2(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PicturesPage()
                                  )
                              );
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
                      context.read<ReportNotifier>().changeOpTime_1('');
                      context.read<ReportNotifier>().changeOpTime_2('');
                      context.read<ReportNotifier>().changeOpTime_3('');
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
