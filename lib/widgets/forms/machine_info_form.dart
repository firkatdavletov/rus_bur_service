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
                    child: AppTextFormFieldWithInitWithoutIcon(
                      initialValue: context.watch<ReportNotifier>().machineModel,
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeMachineModel(value);
                      },
                      validator: _validate,
                      helperText: 'Модель машины',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitWithoutIcon(
                      initialValue: context.watch<ReportNotifier>().machineNumb,
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeMachineNumb(value);
                      },
                      validator: _validate,
                      helperText: 'Серийный номер машины',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitWithoutIcon(
                      initialValue: context.watch<ReportNotifier>().machineYear,
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeMachineYear(value);
                      },
                      validator: _validate,
                      helperText: 'Год выпуска',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitWithoutIcon(
                      initialValue: context.watch<ReportNotifier>().engineModel,
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeEngineModel(value);
                      },
                      validator: _validate,
                      helperText: 'Модель двигателя',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitWithoutIcon(
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeEngineNumb(value);
                      },
                      validator: _validate,
                      initialValue: context.watch<ReportNotifier>().engineNumb,
                      helperText: 'Серийный номер двигателя',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitSuffix(
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeOpTime_1(int.parse(value));
                      },
                      validator: _validate,
                      icon: Icon(Icons.arrow_right),
                      label: 'Наработка двигателя',
                      initialValue: context.watch<ReportNotifier>().opTime_1.toString(),
                      helperText: '',
                      suffixText: 'мото-ч.',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitSuffix(
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeOpTime_2(int.parse(value));
                      },
                      validator: _validate,
                      icon: Icon(Icons.arrow_right),
                      label: '',
                      initialValue: context.watch<ReportNotifier>().opTime_2.toString(),
                      helperText: '',
                      suffixText: 'уд/ч',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitSuffix(
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeOpTime_3(int.parse(value));
                      },
                      validator: _validate,
                      icon: Icon(Icons.arrow_right),
                      label: '',
                      initialValue: context.watch<ReportNotifier>().opTime_3.toString(),
                      helperText: '',
                      suffixText: 'пог.м',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitSuffix(
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeOpTime_4(int.parse(value));
                      },
                      validator: _validate,
                      icon: Icon(Icons.arrow_right),
                      label: 'Наработка гусеничного движителя',
                      initialValue: context.watch<ReportNotifier>().opTime_4.toString(),
                      helperText: '',
                      suffixText: 'пог.м',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitMaxLines(
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeNote(value);
                      },
                      validator: _validate,
                      maxLines: 5,
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
              child: ElevatedButton (
                  onPressed: () {
                    _formKey_1.currentState!.save();
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
                  onPressed: () {
                    if (_formKey_1.currentState!.validate()) {
                      _formKey_1.currentState!.save();
                      db.upgradeReport(context);
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
