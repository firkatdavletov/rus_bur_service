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
    TextEditingController _textEditingController1 = TextEditingController(text: context.watch<ReportNotifier>().machineModel);
    TextEditingController _textEditingController2 = TextEditingController(text: context.watch<ReportNotifier>().machineNumb);
    TextEditingController _textEditingController3 = TextEditingController(text: context.watch<ReportNotifier>().machineYear);
    TextEditingController _textEditingController4 = TextEditingController(text: context.watch<ReportNotifier>().engineModel);
    TextEditingController _textEditingController5 = TextEditingController(text: context.watch<ReportNotifier>().engineNumb);
    TextEditingController _textEditingController6 = TextEditingController(text: context.watch<ReportNotifier>().opTime_1.toString());
    TextEditingController _textEditingController7 = TextEditingController(text: context.watch<ReportNotifier>().opTime_2.toString());
    TextEditingController _textEditingController8 = TextEditingController(text: context.watch<ReportNotifier>().opTime_3.toString());
    TextEditingController _textEditingController9 = TextEditingController(text: context.watch<ReportNotifier>().opTime_4.toString());
    TextEditingController _textEditingController10 = TextEditingController(text: context.watch<ReportNotifier>().note);

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
                      validator: _validate,
                      helperText: 'Модель машины',
                      textEditingController: _textEditingController1,
                    )
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      textEditingController: _textEditingController2,
                      validator: _validate,
                      helperText: 'Серийный номер машины',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      textEditingController: _textEditingController3,
                      validator: _validate,
                      helperText: 'Год выпуска',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      textEditingController: _textEditingController4,
                      validator: _validate,
                      helperText: 'Модель двигателя',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      validator: _validate,
                      textEditingController: _textEditingController5,
                      helperText: 'Серийный номер двигателя',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFieldSuffix(
                      validator: _validate,
                      label: 'Наработка двигателя',
                      controller: _textEditingController6,
                      helperText: '',
                      suffixText: 'мото-ч.',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFieldSuffix(
                      validator: _validate,
                      label: '',
                      controller: _textEditingController7,
                      helperText: '',
                      suffixText: 'уд/ч',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFieldSuffix(
                      validator: _validate,
                      label: '',
                      controller: _textEditingController8,
                      helperText: '',
                      suffixText: 'пог.м',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFieldSuffix(
                      validator: _validate,
                      label: 'Наработка гусеничного движителя',
                      controller: _textEditingController9,
                      helperText: '',
                      suffixText: 'пог.м',
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextField(
                      validator: _validate,
                      textEditingController: _textEditingController10,
                      helperText: 'Примечание',
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
                    context.read<ReportNotifier>().changeMachineModel(_textEditingController1.text);
                    context.read<ReportNotifier>().changeMachineNumb(_textEditingController2.text);
                    context.read<ReportNotifier>().changeMachineYear(_textEditingController3.text);
                    context.read<ReportNotifier>().changeEngineModel(_textEditingController4.text);
                    context.read<ReportNotifier>().changeEngineNumb(_textEditingController5.text);
                    context.read<ReportNotifier>().changeOpTime_1(int.parse(_textEditingController6.text));
                    context.read<ReportNotifier>().changeOpTime_2(int.parse(_textEditingController7.text));
                    context.read<ReportNotifier>().changeOpTime_3(int.parse(_textEditingController8.text));
                    context.read<ReportNotifier>().changeOpTime_4(int.parse(_textEditingController9.text));
                    context.read<ReportNotifier>().changeNote(_textEditingController10.text);
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
                      context.read<ReportNotifier>().changeMachineModel(_textEditingController1.text);
                      context.read<ReportNotifier>().changeMachineNumb(_textEditingController2.text);
                      context.read<ReportNotifier>().changeMachineYear(_textEditingController3.text);
                      context.read<ReportNotifier>().changeEngineModel(_textEditingController4.text);
                      context.read<ReportNotifier>().changeEngineNumb(_textEditingController5.text);
                      context.read<ReportNotifier>().changeOpTime_1(int.parse(_textEditingController6.text));
                      context.read<ReportNotifier>().changeOpTime_2(int.parse(_textEditingController7.text));
                      context.read<ReportNotifier>().changeOpTime_3(int.parse(_textEditingController8.text));
                      context.read<ReportNotifier>().changeOpTime_4(int.parse(_textEditingController9.text));
                      context.read<ReportNotifier>().changeNote(_textEditingController10.text);
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
