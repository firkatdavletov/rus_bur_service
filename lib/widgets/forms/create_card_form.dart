import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/diagnostic_card.dart';
import 'package:rus_bur_service/pages/agreed_diagnostic_cards_page.dart';
import 'package:rus_bur_service/pages/card_pictures_page.dart';
import 'package:rus_bur_service/pages/spares_page.dart';
import 'app_text_form_field.dart';

class CreateCardForm extends StatefulWidget {
  const CreateCardForm({
    Key? key,
  }) : super(key: key);

  @override
  _CreateCardFormState createState() => _CreateCardFormState();
}

class _CreateCardFormState extends State<CreateCardForm> {
  final _formKey_1 = GlobalKey<FormState>();

  _validate(String value) {
    if (value.isEmpty) {
      return 'Пожалуйста, заполните поле';
    }
  }



  late String _dropdownConclusionValue;
  List<String> _conclusion = ['НЕ ВЫБРАНО', 'УСПЕШНО', 'ВНИМАНИЕ', 'НЕУДАЧА'];
  late String _dropdownPriorityValue;
  List<String> _priority = ['НЕ ВЫБРАНО','РЕКОМЕНДУЕТСЯ','ПЛАНОВО','СРОЧНО'];

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    int _conclusionState = Provider.of<DiagnosticCardsNotifier>(context, listen: false).conclusion;
    int _priorityState = Provider.of<DiagnosticCardsNotifier>(context, listen: false).priority;

    switch (_conclusionState) {
      case 0:
        _dropdownConclusionValue = 'НЕ ВЫБРАНО';
        break;
      case 1:
        _dropdownConclusionValue = 'УСПЕШНО';
        break;
      case 2:
        _dropdownConclusionValue = 'ВНИМАНИЕ';
        break;
      case 3:
        _dropdownConclusionValue = 'НЕУДАЧА';
    }

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
                  SizedBox(height: 20,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text('ЗАКЛЮЧЕНИЕ :'),
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          child: DropdownButton<String>(
                            value: _dropdownConclusionValue,
                            items: _conclusion.map((String value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(value)
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                context.read<DiagnosticCardsNotifier>().changeConclusion(
                                    newValue == 'УСПЕШНО'
                                        ? 1
                                        : newValue == 'ВНИМАНИЕ'
                                        ? 2
                                        : newValue == 'НЕУДАЧА'
                                        ? 3
                                        : 0
                                );
                              });
                            },
                          ),
                        ),
                        Icon(
                            Icons.check_circle,
                            color: _conclusionState == 1
                                ? Colors.lightGreen
                                : _conclusionState == 2
                                ? Colors.orangeAccent
                                : _conclusionState == 3
                                ? Colors.redAccent
                                : _conclusionState == 0
                                ? Colors.grey
                                : null
                        )
                      ],
                    ),
                  ),
                  Visibility(
                      visible: _conclusionState != 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: AppTextFormFieldWithInit(
                          initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).description,
                          onSaved: (value) {
                            context.read<DiagnosticCardsNotifier>().changeDescription(value);
                          },
                          validator: _validate,
                          icon: Icon(Icons.format_quote_sharp),
                          label: 'Описание проблемы',
                          helperText: '',
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInit(
                      initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).area,
                      onSaved: (value) {
                        context.read<DiagnosticCardsNotifier>().changeArea(value);
                      },
                      validator: _validate,
                      icon: Icon(Icons.format_quote_sharp),
                      label: 'Зона выявления дефекта',
                      helperText: '',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInit(
                      initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).damage,
                      onSaved: (value) {
                        context.read<DiagnosticCardsNotifier>().changeDamage(value);
                      },
                      validator: _validate,
                      icon: Icon(Icons.car_repair),
                      label: 'Повреждения',
                      helperText: '',
                    ),
                  ),
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
                                context.read<DiagnosticCardsNotifier>().changePriority(
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
                            Icons.check_circle,
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInit(
                      onSaved: (value) {
                        context.read<DiagnosticCardsNotifier>().changeRecommend(value);
                      },
                      validator: _validate,
                      icon: Icon(Icons.recommend),
                      label: 'Рекомендации',
                      initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).recommend,
                      helperText: '',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInit(
                      onSaved: (value) {
                        context.read<DiagnosticCardsNotifier>().changeTime(value);
                      },
                      validator: _validate,
                      icon: Icon(Icons.watch),
                      label: 'Время устранения',
                      initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).time,
                      helperText: '',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInit(
                      onSaved: (value) {
                        context.read<DiagnosticCardsNotifier>().changeEffect(value);
                      },
                      validator: _validate,
                      icon: Icon(Icons.east_rounded),
                      label: 'Эффект',
                      initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).effect,
                      helperText: '',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInit(
                      onSaved: (value) {
                        context.read<DiagnosticCardsNotifier>().changeManHours(int.parse(value));
                      },
                      validator: _validate,
                      icon: Icon(Icons.person_sharp),
                      label: 'Человеко-часы',
                      initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).manHours.toString(),
                      helperText: '',
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        _formKey_1.currentState!.save();
                        _upgradeCard();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SparesPage()
                            )
                        );
                      },
                      child: Text('Перечень необходимых запчастей')
                  ),
                  TextButton(
                      onPressed: () {
                        _formKey_1.currentState!.save();
                        _upgradeCard();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardPicturesPage()
                            )
                        );
                      },
                      child: Text('Фотографии')
                  ),
              ],
            )
          )
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
                            builder: (context) => AgreedDiagnosticCardsPage()
                        )
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Container(width: 5,),
                      _width > 400
                          ? Text('Назад')
                          : Text(''),
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
                      _upgradeCard();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new AgreedDiagnosticCardsPage()
                          )
                      );
                    }
                  },
                  child: Row(
                    children: [
                      _width > 400
                          ? Text('Сохранить')
                          : Text(''),
                      Container(width: 5,),
                      Icon(Icons.save)
                    ],
                  )
              ),
            ),
          ],
        ),
      ],
    );
  }

  _upgradeCard() {
    DiagnosticCard _newCard = DiagnosticCard(
        id: Provider.of<DiagnosticCardsNotifier>(context, listen: false).id,
        name: Provider.of<DiagnosticCardsNotifier>(context, listen: false).name,
        operationId: Provider.of<DiagnosticCardsNotifier>(context, listen: false).operationId,
        reportId: Provider.of<DiagnosticCardsNotifier>(context, listen: false).reportId,
        conclusion: Provider.of<DiagnosticCardsNotifier>(context, listen: false).conclusion,
        description: Provider.of<DiagnosticCardsNotifier>(context, listen: false).description,
        area: Provider.of<DiagnosticCardsNotifier>(context, listen: false).area,
        damage: Provider.of<DiagnosticCardsNotifier>(context, listen: false).damage,
        priority: Provider.of<DiagnosticCardsNotifier>(context, listen: false).priority,
        recommend: Provider.of<DiagnosticCardsNotifier>(context, listen: false).recommend,
        time: Provider.of<DiagnosticCardsNotifier>(context, listen: false).time,
        effect: Provider.of<DiagnosticCardsNotifier>(context, listen: false).effect,
        manHours: Provider.of<DiagnosticCardsNotifier>(context, listen: false).manHours,
        part: Provider.of<DiagnosticCardsNotifier>(context, listen: false).part
    );
    db.upgradeCard(_newCard);
  }
}
