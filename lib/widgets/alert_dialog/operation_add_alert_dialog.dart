import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/operation.dart';
import 'package:rus_bur_service/models/part.dart';
import 'package:rus_bur_service/pages/operations_settings_page.dart';
import 'package:rus_bur_service/pages/parts_settings_page.dart';
import 'package:rus_bur_service/widgets/forms/app_text_form_field.dart';

import '../../main.dart';

class OperationAddAlertDialog extends StatefulWidget {
  final int partId;
  const OperationAddAlertDialog({
    Key? key,
    required this.partId
  }) : super(key: key);

  @override
  _OperationAddAlertDialogState createState() => _OperationAddAlertDialogState();
}

class _OperationAddAlertDialogState extends State<OperationAddAlertDialog> {
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
                  child: AppTextFormFieldWithoutIcon(
                      helperText: '',
                      onChanged: (String value) {
                        _name = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, заполните поле';
                        }
                      },
                      label: 'Название'
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
                                Operation _operation = Operation(
                                    id: 0,
                                    name: _name,
                                    partId: widget.partId,
                                    isRequired: true
                                );
                                db.insertOperation(_operation);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OperationsSettingPage(partId: widget.partId,)
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
