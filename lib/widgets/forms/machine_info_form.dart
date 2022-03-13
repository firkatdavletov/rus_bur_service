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
  _validateInt(String value) {
    if (value.isNotEmpty) {
      try{
        var numb = int.parse(value);
      } on FormatException {
        return 'Введите целое число';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('machine model in form: ${context.watch<ReportNotifier>().machineModel}');
    double _width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Form(
              key: _formKey_1,
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      initial: context.watch<ReportNotifier>().machineModel,
                      validator: _validate,
                      helperText: 'Модель машины',
                      onChanged: (value) {
                        context.read<ReportNotifier>().changeMachineModel(value);
                      },
                      inputType: TextInputType.text,
                    )
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      initial: context.watch<ReportNotifier>().machineNumb,
                      validator: _validate,
                      helperText: 'Серийный номер машины',
                      onChanged: (value) {
                        context.read<ReportNotifier>().changeMachineNumb(value);
                      },
                      inputType: TextInputType.text,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      initial: context.watch<ReportNotifier>().machineYear,
                      onChanged: (value) {
                        context.read<ReportNotifier>().changeMachineYear(value);
                      },
                      validator: _validate,
                      helperText: 'Год выпуска',
                      inputType: TextInputType.number,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      initial: context.watch<ReportNotifier>().engineModel,
                      onChanged: (value) {
                        context.read<ReportNotifier>().changeEngineModel(value);
                      },
                      validator: _validate,
                      helperText: 'Модель двигателя',
                      inputType: TextInputType.text,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      initial: context.watch<ReportNotifier>().engineNumb,
                      onChanged: (value) {
                        context.read<ReportNotifier>().changeEngineNumb(value);
                      },
                      validator: _validate,
                      helperText: 'Серийный номер двигателя',
                      inputType: TextInputType.text,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFieldSuffix(
                      initial: context.watch<ReportNotifier>().opTime_1 != 0
                          ? context.watch<ReportNotifier>().opTime_1.toString()
                          : '',
                      validator: _validateInt,
                      label: 'Наработка двигателя',
                      onChanged: (value) {
                        int numb = 0;
                        try{
                          numb = int.parse(value);
                        } on FormatException {
                          context.read<ReportNotifier>().changeOpTime_1(0);
                        } finally {
                          context.read<ReportNotifier>().changeOpTime_1(numb);
                        }
                      },
                      helperText: '',
                      suffix: Text('мото-ч.'),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFieldSuffix(
                      initial: context.watch<ReportNotifier>().opTime_2 != 0
                          ?context.watch<ReportNotifier>().opTime_2.toString()
                          : '',
                      validator: _validateInt,
                      label: 'Наработка в уд/ч',
                      onChanged: (value) {
                        int numb = 0;
                        try{
                          numb = int.parse(value);
                        } on FormatException {
                          context.read<ReportNotifier>().changeOpTime_2(0);
                        } finally {
                          context.read<ReportNotifier>().changeOpTime_2(numb);
                        }
                      },
                      helperText: '',
                      suffix: Text('уд/ч'),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFieldSuffix(
                      initial: context.watch<ReportNotifier>().opTime_3 != 0
                          ?context.watch<ReportNotifier>().opTime_3.toString()
                          : '',
                      validator: _validateInt,
                      label: 'Наработка в пог. м',
                      onChanged: (value) {
                        int numb = 0;
                        try{
                          numb = int.parse(value);
                        } on FormatException {
                          context.read<ReportNotifier>().changeOpTime_3(0);
                        } finally {
                          context.read<ReportNotifier>().changeOpTime_3(numb);
                        }
                      },
                      helperText: '',
                      suffix: Text('пог.м'),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFieldSuffix(
                      initial: context.watch<ReportNotifier>().opTime_4 != 0
                          ? context.watch<ReportNotifier>().opTime_4.toString()
                          : '',
                      validator: _validateInt,
                      label: 'Наработка гусеничного движителя',
                      onChanged: (value) {
                        int numb = 0;
                        try{
                          numb = int.parse(value);
                        } on FormatException {
                          context.read<ReportNotifier>().changeOpTime_4(0);
                        } finally {
                          context.read<ReportNotifier>().changeOpTime_4(numb);
                        }
                      },
                      helperText: '',
                      suffix: Text('пог.м'),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      initial: context.watch<ReportNotifier>().note,
                      onChanged: (value) {
                        context.read<ReportNotifier>().changeNote(value);
                      },
                      validator: (value) => null,
                      helperText: 'Примечание',
                      inputType: TextInputType.text,
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
              child: ElevatedButton (
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReportMainPage()
                        )
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Container(width: 5,),
                      _width > 400
                          ? Text('Данные заказчика')
                          : Text(''),
                    ],
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: ElevatedButton (
                  onPressed: () async {
                    if (_formKey_1.currentState!.validate()) {
                      int result = await db.upgradeReport(context);
                      print('result of upgrade: $result');
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
                      _width > 400
                          ? Text('Фотографии')
                          : Text(''),
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
