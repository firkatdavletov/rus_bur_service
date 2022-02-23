import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/controller/spare_notifier.dart';
import 'package:rus_bur_service/models/spare.dart';
import 'package:rus_bur_service/pages/spares_page.dart';
import '../../main.dart';
import 'app_text_form_field.dart';

class AddSpareForm extends StatefulWidget {
  final bool isNewSpare;
  //final Spare spare;
  const AddSpareForm({
    Key? key,
    //required this.spare,
    required this.isNewSpare
  }) : super(key: key);

  @override
  _AddSpareFormState createState() => _AddSpareFormState();
}

class _AddSpareFormState extends State<AddSpareForm> {
  final _formKey_1 = GlobalKey<FormState>();
  _validate(String value) {
    if (value.isEmpty) {
      return 'Пожалуйста, заполните поле';
    }
  }

  _validateInt(String value) {
    if (value.isEmpty) {
      return 'Пожалуйста, заполните поле';
    } else if (value.contains(RegExp(r'0-9'))){
      return 'Введите число';
    }
  }

  late String _dropdownPriorityValue;
  List<String> _priority = ['РЕКОМЕНДУЕТСЯ','ПЛАНОВО','СРОЧНО'];

  @override
  Widget build(BuildContext context) {

    int _priorityState = Provider.of<SpareNotifier>(context, listen: false).priority;
    switch (_priorityState) {
      case 0:
        _dropdownPriorityValue = 'НЕ ВЫБРАНО';
        break;
      case 1:
        _dropdownPriorityValue = 'РЕКОМЕНДУЕТСЯ';
        break;
      case 2:
        _dropdownPriorityValue = 'ПЛАНОВО';
        break;
      case 3:
        _dropdownPriorityValue = 'СРОЧНО';
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Form(
                key: _formKey_1,
                child: ListView(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text('ПРИОРИТЕТ :'),
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: DropdownButton<String>(
                              value: _dropdownPriorityValue,
                              items: _priority.map((String value) {
                                return DropdownMenuItem(
                                    value: value,
                                    child: Text(value)
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  context.read<SpareNotifier>().changePriority(
                                      newValue == 'РЕКОМЕНДУЕТСЯ'
                                          ? 1
                                          : newValue == 'ПЛАНОВО'
                                          ? 2
                                          : newValue == 'СРОЧНО'
                                          ? 3
                                          : 0
                                  );
                                });
                              },
                            ),
                          ),
                          Icon(
                              Icons.filter_1_rounded,
                              color: _priorityState == 1
                                  ? Colors.lightGreen
                                  : _priorityState == 2
                                  ? Colors.orangeAccent
                                  : _priorityState == 3
                                  ? Colors.redAccent
                                  : _priorityState == 0
                                  ? Colors.grey
                                  : null
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      child: Text('Каталожный номер', style: TextStyle(color: Colors.blueAccent)),
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: AppTextFormFieldWithInitWithoutIcon(
                        initialValue: Provider.of<SpareNotifier>(context, listen: false).number,
                        onSaved: (value) {
                          context.read<SpareNotifier>().changeNumber(value);
                        },
                        validator: _validate,
                        helperText: '',
                      ),
                    ),
                    Divider(),
                    Padding(
                      child: Text('Наименование', style: TextStyle(color: Colors.blueAccent)),
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: AppTextFormFieldWithInitWithoutIcon(
                        initialValue: Provider.of<SpareNotifier>(context, listen: false).name,
                        onSaved: (value) {
                          context.read<SpareNotifier>().changeName(value);
                        },
                        validator: _validate,
                        helperText: '',
                      ),
                    ),
                    Divider(),
                    Padding(
                      child: Text('Количество', style: TextStyle(color: Colors.blueAccent)),
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: AppTextFormFieldWithInitWithoutIcon(
                        initialValue: Provider.of<SpareNotifier>(context, listen: false).quantity.toString(),
                        onSaved: (value) {
                          context.read<SpareNotifier>().changeQuantity(int.parse(value));
                        },
                        validator: _validateInt,
                        helperText: '',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: AppDropDownFormField(
                        itemsVisible: 3,
                        items: [
                          'шт.', 'л', 'компл.'
                        ],
                        initialValue: Provider.of<SpareNotifier>(context, listen: false).measure,
                        onSaved: (value) {
                          context.read<SpareNotifier>().changeMeasure(value);
                        },
                        icon: Icon(Icons.car_repair),
                        label: 'Единица измерения',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: AppDropDownFormField(
                        itemsVisible: 5,
                        items: [
                          'Износ', 'Отсутствие', 'Плановая замена', 'Модернизация', 'Несоответствие'
                        ],
                        initialValue: Provider.of<SpareNotifier>(context, listen: false).issue,
                        onSaved: (value) {
                          context.read<SpareNotifier>().changeIssue(value);
                        },
                        icon: Icon(Icons.car_repair),
                        label: 'Проблема',
                      ),
                    ),
                  ],
                )
            )
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: ElevatedButton (
                  onPressed: () {
                    if (_formKey_1.currentState!.validate()) {
                      _formKey_1.currentState!.save();
                      Spare _newSpare = Spare(
                          id: Provider.of<SpareNotifier>(context, listen: false).id,
                          name: Provider.of<SpareNotifier>(context, listen: false).name,
                          measure: Provider.of<SpareNotifier>(context, listen: false).measure,
                          issue: Provider.of<SpareNotifier>(context, listen: false).issue,
                          cardId: Provider.of<DiagnosticCardsNotifier>(context, listen: false).id,
                          quantity: Provider.of<SpareNotifier>(context, listen: false).quantity,
                          number: Provider.of<SpareNotifier>(context, listen: false).number,
                          priority: Provider.of<SpareNotifier>(context, listen: false).priority,
                          part: Provider.of<DiagnosticCardsNotifier>(context, listen: false).part
                      );
                      widget.isNewSpare
                          ? db.insertSpare(_newSpare)
                          : db.upgradeSpare(_newSpare);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new SparesPage()
                          )
                      );
                    }
                  },
                  child: Text(widget.isNewSpare? 'Добавить' : 'Сохранить')
              ),
            )
          ],
        )
      ],
    );
  }
}
