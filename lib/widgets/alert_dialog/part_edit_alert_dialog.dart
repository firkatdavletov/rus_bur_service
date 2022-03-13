import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/part.dart';
import 'package:rus_bur_service/pages/parts_settings_page.dart';
import 'package:rus_bur_service/widgets/forms/app_text_form_field.dart';

import '../../main.dart';

class PartAddAlertDialog extends StatefulWidget {
  const PartAddAlertDialog({Key? key}) : super(key: key);

  @override
  _PartAddAlertDialogState createState() => _PartAddAlertDialogState();
}

class _PartAddAlertDialogState extends State<PartAddAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 350.0,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: AppTextField(
                      helperText: 'Название',
                      onChanged: (String value) {
                        _name = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, заполните поле';
                        }
                      },
                      initial: '',
                      inputType: TextInputType.text,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                Part _part = Part(
                                    id: 0,
                                    name: _name
                                );
                                db.insertPart(_part);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PartsSettingPage()
                                    )
                                );
                              }
                            },
                            child: Text('Создать')
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('Отмена')
                        )
                    ),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
