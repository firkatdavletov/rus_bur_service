import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Form(
              key: _formKey_1,
              child: ListView(
                children: [
                  SizedBox(height: 20,),
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
                ],
              )
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: OutlinedButton (
                  onPressed: () {
                    if (_formKey_1.currentState!.validate()) {
                      _formKey_1.currentState!.save();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportMainPage()
                          )
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Container(width: 5,),
                      Text('Данные заказчика'),
                    ],
                  )
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
                  child: Row(
                    children: [
                      Text('Фотографии'),
                      Container(width: 5,),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  )
              ),
            )
          ],
        )
      ],
    );
  }
}