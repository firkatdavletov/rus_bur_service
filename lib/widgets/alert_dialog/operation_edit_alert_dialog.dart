import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/operation_notifier.dart';
import 'package:rus_bur_service/models/operation.dart';
import 'package:rus_bur_service/pages/operations_settings_page.dart';
import 'package:rus_bur_service/widgets/forms/app_text_form_field.dart';

import '../../main.dart';

class OperationEditAlertDialog extends StatefulWidget {
  final bool isNew;
  const OperationEditAlertDialog({
    required this.isNew,
    Key? key,
  }) : super(key: key);

  @override
  _OperationEditAlertDialogState createState() => _OperationEditAlertDialogState();
}

class _OperationEditAlertDialogState extends State<OperationEditAlertDialog> {
  final _formKey = GlobalKey<FormState>();

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
                    initial: context.watch<OperationNotifier>().name,
                      helperText: 'Название',
                      onChanged: (String value) {
                        context.read<OperationNotifier>().changeName(value);
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, заполните поле';
                        }
                      },
                    inputType: TextInputType.text,
                  ),
                ),
                CheckboxListTile(
                    value: context.watch<OperationNotifier>().isRequired,
                    onChanged: (value) {
                      setState(() {
                        context.read<OperationNotifier>().changeIsRequired(value);
                      });
                    },
                    title: Text('Обязательно'),
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
                                    id: Provider.of<OperationNotifier>(context, listen: false).id,
                                    name: Provider.of<OperationNotifier>(context, listen: false).name,
                                    partId: Provider.of<OperationNotifier>(context, listen: false).partId,
                                    isRequired: Provider.of<OperationNotifier>(context, listen: false).isRequired
                                );
                                widget.isNew
                                    ? db.insertOperation(_operation)
                                    : db.upgradeOperation(_operation);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OperationsSettingPage(
                                            partId: Provider.of<OperationNotifier>(context, listen: false).partId
                                        )
                                    )
                                );
                              }
                            },
                            child: Text(widget.isNew? 'Создать' : 'Сохранить')
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
