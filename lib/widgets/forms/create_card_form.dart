import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/diagnostic_card.dart';
import 'package:rus_bur_service/models/status.dart';
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
  List<String> _conclusion = ['УСПЕШНО', 'ВНИМАНИЕ', 'НЕУДАЧА'];
  late String _dropdownPriorityValue;
  List<String> _priority = ['РЕКОМЕНДУЕТСЯ','ПЛАНОВО','СРОЧНО'];
  Status status = Status();



  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    int _conclusionState = Provider.of<DiagnosticCardsNotifier>(context, listen: false).conclusion;
    int _priorityState = Provider.of<DiagnosticCardsNotifier>(context, listen: false).priority;
    int currentStatus = Provider.of<DiagnosticCardsNotifier>(context, listen: false).status;

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

    const termStatusType1 = ['день', 'неделя', 'месяц'];
    const termStatusType2 = ['дней', 'недель', 'месяцев'];
    const termStatusType3 = ['дня', 'недели', 'месяца'];

    int _termStatus = Provider.of<DiagnosticCardsNotifier>(context, listen: false).termStatus;
    int _termWeek = Provider.of<DiagnosticCardsNotifier>(context, listen: false).termWeek;
    String _prefix;

    if (_termWeek%10 == 1) {
      _prefix = termStatusType1[_termStatus];
    } else if(_termWeek > 1 && _termWeek < 5) {
      _prefix = termStatusType3[_termStatus];
    } else {
      _prefix = termStatusType2[_termStatus];
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10.0,),
                        Expanded(
                          child: Text('ЗАКЛЮЧЕНИЕ :'),
                          flex: 2,//padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        ),
                        Expanded(
                          flex: 3,//padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                                if (newValue == 'УСПЕШНО') {
                                  context.read<DiagnosticCardsNotifier>().changeDescription('');
                                  context.read<DiagnosticCardsNotifier>().changeArea('');
                                  context.read<DiagnosticCardsNotifier>().changeDamage('');
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Icon(
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10.0,),
                        Expanded(
                          child: Text('ПРИОРИТЕТ :'),
                          flex: 2,//padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        ),
                        Expanded(
                          flex: 3,//padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                        Expanded(
                            flex: 1,
                            child: Icon(
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
                        )
                      ],
                    ),
                  ),
                  Visibility(
                      visible: _conclusionState != 1,
                      child: ExpansionTile(
                        title: Text('Описание проблемы'),
                        maintainState: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: AppTextFormFieldWithInitWithoutIcon(
                              initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).description,
                              onSaved: (value) {
                                context.read<DiagnosticCardsNotifier>().changeDescription(value);
                              },
                              validator: _validate,
                              helperText: '',
                            ),
                          )
                        ],
                      ),
                  ),
                  Visibility(
                      visible: _conclusionState != 1,
                      child: ExpansionTile(
                        title: Text('Зона выявления дефекта'),
                        maintainState: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: AppTextFormFieldWithInitWithoutIcon(
                              initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).area,
                              onSaved: (value) {
                                context.read<DiagnosticCardsNotifier>().changeArea(value);
                              },
                              validator: _validate,
                              helperText: '',
                            ),
                          )
                        ],
                      )
                  ),
                  Visibility(
                      visible: _conclusionState != 1,
                      child: ExpansionTile(
                        title: Text('Повреждения'),
                        maintainState: true,
                        children: [
                          CheckboxListTile(
                            value: currentStatus&status.status1 == status.status1,
                            onChanged: (value) {
                              setState(() {
                                if (currentStatus&status.status1 == status.status1) {
                                  int tempStatus = ~status.status1;
                                  currentStatus = currentStatus&tempStatus;
                                  context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                                } else {
                                  currentStatus |= status.status1;
                                  context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                                }
                              });
                            },
                            title: Text('Износ'),
                          ),
                          CheckboxListTile(
                            value: currentStatus&status.status2 == status.status2,
                            onChanged: (value) {
                              setState(() {
                                if (currentStatus&status.status2 == status.status2) {
                                  int tempStatus = ~status.status2;
                                  currentStatus = currentStatus&tempStatus;
                                  context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                                } else {
                                  currentStatus |= status.status2;
                                  context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                                }
                              });
                            },
                            title: Text('Отсутствие'),
                          ),
                          CheckboxListTile(
                            value: currentStatus&status.status3 == status.status3,
                            onChanged: (value) {
                              setState(() {
                                if (currentStatus&status.status3 == status.status3) {
                                  int tempStatus = ~status.status3;
                                  currentStatus = currentStatus&tempStatus;
                                  context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                                } else {
                                  currentStatus |= status.status3;
                                  context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                                }
                              });
                            },
                            title: Text('Плановая замена'),
                          ),
                          CheckboxListTile(
                            value: currentStatus&status.status4 == status.status4,
                            onChanged: (value) {
                              setState(() {
                                if (currentStatus&status.status4 == status.status4) {
                                  int tempStatus = ~status.status4;
                                  currentStatus = currentStatus&tempStatus;
                                  context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                                } else {
                                  currentStatus |= status.status4;
                                  context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                                }
                              });
                            },
                            title: Text('Модернизация'),
                          ),
                          CheckboxListTile(
                            value: currentStatus&status.status5 == status.status5,
                            onChanged: (value) {
                              setState(() {
                                if (currentStatus&status.status5 == status.status5) {
                                  int tempStatus = ~status.status5;
                                  currentStatus = currentStatus&tempStatus;
                                  context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                                } else {
                                  currentStatus |= status.status5;
                                  context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                                }
                              });
                            },
                            title: Text('Несоответствие'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: AppTextFormFieldWithInit(
                                onSaved: (value) {
                                  context.read<DiagnosticCardsNotifier>().changeDamage(value);
                                },
                                validator: (value) {
                                  if (value.length > 35) {
                                    return 'Максимальное количество символов - 35';
                                  }
                                },
                                icon: Icon(Icons.add),
                                label: 'Другое',
                                initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).damage,
                                helperText: ''
                            ),
                          ),
                        ],
                      )
                  ),
                  ExpansionTile(
                    title: Text('Риски, положительный эффект'),
                    maintainState: true,
                    children: [
                      CheckboxListTile(
                        value: currentStatus&status.status6 == status.status6,
                        onChanged: (value) {
                          setState(() {
                            if (currentStatus&status.status6 == status.status6) {
                              int reverseStatus = ~status.status6;
                              currentStatus = currentStatus&reverseStatus;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            } else {
                              currentStatus |= status.status6;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            }
                          });
                        },
                        title: Text('Снижение расходов'),
                      ),
                      CheckboxListTile(
                        value: currentStatus&status.status7 == status.status7,
                        onChanged: (value) {
                          setState(() {
                            if (currentStatus&status.status7 == status.status7) {
                              int reverseStatus = ~status.status7;
                              currentStatus = currentStatus&reverseStatus;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            } else {
                              currentStatus |= status.status7;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            }
                          });
                        },
                        title: Text('Безопасность работников'),
                      ),
                      CheckboxListTile(
                        value: currentStatus&status.status8 == status.status8,
                        onChanged: (value) {
                          setState(() {
                            if (currentStatus&status.status8 == status.status8) {
                              int reverseStatus = ~status.status8;
                              currentStatus = currentStatus&reverseStatus;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            } else {
                              currentStatus |= status.status8;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            }
                          });
                        },
                        title: Text('Профилактическое обслуживание'),
                      ),
                      CheckboxListTile(
                        value: currentStatus&status.status9 == status.status9,
                        onChanged: (value) {
                          setState(() {
                            if (currentStatus&status.status9 == status.status9) {
                              int reverseStatus = ~status.status9;
                              currentStatus = currentStatus&reverseStatus;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            } else {
                              currentStatus |= status.status9;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            }
                          });
                        },
                        title: Text('Сокращение времени простоя'),
                      ),
                      CheckboxListTile(
                        value: currentStatus&status.status10 == status.status10,
                        onChanged: (value) {
                          setState(() {
                            if (currentStatus&status.status10 == status.status10) {
                              int reverseStatus = ~status.status10;
                              currentStatus = currentStatus&reverseStatus;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            } else {
                              currentStatus |= status.status10;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            }
                          });
                        },
                        title: Text('Безопасность оборудования'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: AppTextFormFieldWithInit(
                            onSaved: (value) {
                              context.read<DiagnosticCardsNotifier>().changeEffect(value);
                            },
                            validator: (value) {
                              if (value.length > 35) {
                                return 'Максимальное количество символов - 35';
                              }
                            },
                            icon: Icon(Icons.add),
                            label: 'Другое',
                            initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).effect,
                            helperText: ''
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Рекомендуемые решения'),
                    maintainState: true,
                    children: [
                      CheckboxListTile(
                        value: currentStatus&status.status11 == status.status11,
                        onChanged: (value) {
                          setState(() {
                            if (currentStatus&status.status11 == status.status11) {
                              int reverseStatus = ~status.status11;
                              currentStatus = currentStatus&reverseStatus;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            } else {
                              currentStatus |= status.status11;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            }
                          });
                        },
                        title: Text('Замена'),
                      ),
                      CheckboxListTile(
                        value: currentStatus&status.status12 == status.status12,
                        onChanged: (value) {
                          setState(() {
                            if (currentStatus&status.status12 == status.status12) {
                              int reverseStatus = ~status.status12;
                              currentStatus = currentStatus&reverseStatus;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            } else {
                              currentStatus |= status.status12;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            }
                          });
                        },
                        title: Text('Ремонт'),
                      ),
                      CheckboxListTile(
                        value: currentStatus&status.status13 == status.status13,
                        onChanged: (value) {
                          setState(() {
                            if (currentStatus&status.status13 == status.status13) {
                              int reverseStatus = ~status.status13;
                              currentStatus = currentStatus&reverseStatus;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            } else {
                              currentStatus |= status.status13;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            }
                          });
                        },
                        title: Text('Установка'),
                      ),
                      CheckboxListTile(
                        value: currentStatus&status.status14 == status.status14,
                        onChanged: (value) {
                          setState(() {
                            if (currentStatus&status.status14 == status.status14) {
                              int reverseStatus = ~status.status14;
                              currentStatus = currentStatus&reverseStatus;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            } else {
                              currentStatus |= status.status14;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            }
                          });
                        },
                        title: Text('Диагностика'),
                      ),
                      CheckboxListTile(
                        value: currentStatus&status.status15 == status.status15,
                        onChanged: (value) {
                          setState(() {
                            if (currentStatus&status.status15 == status.status15) {
                              int reverseStatus = ~status.status15;
                              currentStatus = currentStatus&reverseStatus;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            } else {
                              currentStatus |= status.status15;
                              context.read<DiagnosticCardsNotifier>().changeStatus(currentStatus);
                            }
                          });
                        },
                        title: Text('Очистка'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: AppTextFormFieldWithInit(
                            onSaved: (value) {
                              context.read<DiagnosticCardsNotifier>().changeRecommend(value);
                            },
                            validator: (value) {
                              if (value.length > 35) {
                                return 'Максимальное количество символов - 35';
                              }
                            },
                            icon: Icon(Icons.add),
                            label: 'Другое',
                            initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).recommend,
                            helperText: ''
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Срок на реализацию'),
                    maintainState: true,
                    children: [
                      TermTextFormField(
                          initialValue:  Provider.of<DiagnosticCardsNotifier>(context, listen: false).termWeek.toString(),
                          onSaved: (value) {
                            context.read<DiagnosticCardsNotifier>().changeTermWeek(int.parse(value!));
                          },
                          validator: (value) {},
                          suffix: GestureDetector(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(_prefix),
                                Icon(Icons.touch_app_outlined, color: Colors.black38,)
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _formKey_1.currentState!.save();
                                if (_termStatus < 2) {
                                  _termStatus++;
                                } else {
                                  _termStatus = 0;
                                }
                                context.read<DiagnosticCardsNotifier>().changeTermStatus(_termStatus);
                              });
                            },
                          )
                      ),
                      AppTextFormFieldWithInitSuffix(
                        suffixText: 'м/ч',
                        onSaved: (value) {
                          context.read<DiagnosticCardsNotifier>().changeTerm_mh(int.parse(value));
                        },
                        validator: _validate,
                        icon: Icon(Icons.minimize),
                        label: '',
                        initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).term_mh.toString(),
                        helperText: '',
                      ),
                      AppTextFormFieldWithInitSuffix(
                        suffixText: 'уд/ч',
                        onSaved: (value) {
                          context.read<DiagnosticCardsNotifier>().changeTerm_bh(int.parse(value));
                        },
                        validator: _validate,
                        icon: Icon(Icons.minimize),
                        label: '',
                        initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).term_bh.toString(),
                        helperText: '',
                      ),
                      AppTextFormFieldWithInitSuffix(
                        suffixText: 'пог.м',
                        onSaved: (value) {
                          context.read<DiagnosticCardsNotifier>().changeTerm_m(int.parse(value));
                        },
                        validator: _validate,
                        icon: Icon(Icons.minimize),
                        label: '',
                        initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).term_m.toString(),
                        helperText: '',
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Трудозатраты'),
                    maintainState: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: AppTextFormFieldWithInitSuffix(
                          onSaved: (value) {
                            context.read<DiagnosticCardsNotifier>().changeManHours(int.parse(value));
                          },
                          validator: _validate,
                          icon: Icon(Icons.person_sharp),
                          label: '',
                          initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).manHours.toString(),
                          helperText: '',
                          suffixText: 'чел.*ч',
                        ),
                      ),
                    ],
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
        termWeek: Provider.of<DiagnosticCardsNotifier>(context, listen: false).termWeek,
        term_mh: Provider.of<DiagnosticCardsNotifier>(context, listen: false).term_mh,
        term_m: Provider.of<DiagnosticCardsNotifier>(context, listen: false).term_m,
        term_bh: Provider.of<DiagnosticCardsNotifier>(context, listen: false).term_bh,
        effect: Provider.of<DiagnosticCardsNotifier>(context, listen: false).effect,
        manHours: Provider.of<DiagnosticCardsNotifier>(context, listen: false).manHours,
        part: Provider.of<DiagnosticCardsNotifier>(context, listen: false).part,
        status: Provider.of<DiagnosticCardsNotifier>(context, listen: false).status,
        termStatus: Provider.of<DiagnosticCardsNotifier>(context, listen: false).termStatus,
    );
    db.upgradeCard(_newCard);
  }
}
