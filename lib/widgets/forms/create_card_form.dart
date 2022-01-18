import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/diagnostic_card.dart';
import 'package:rus_bur_service/pages/agreed_diagnostic_areas_page.dart';
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
                      initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).conclusion,
                      onSaved: (value) {
                        context.read<DiagnosticCardsNotifier>().changeConclusion(value);
                      },
                      validator: _validate,
                      icon: Icon(Icons.circle, color: Colors.green,),
                      label: 'Заключение',
                      helperText: '',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInit(
                      initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).description,
                      onSaved: (value) {
                        context.read<DiagnosticCardsNotifier>().changeDescription(value);
                      },
                      validator: _validate,
                      icon: Icon(Icons.format_quote_sharp),
                      label: 'Решение проблемы',
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInit(
                      initialValue: Provider.of<DiagnosticCardsNotifier>(context, listen: false).priority,
                      onSaved: (value) {
                        context.read<DiagnosticCardsNotifier>().changePriority(value);
                      },
                      validator: _validate,
                      icon: Icon(Icons.warning_amber_outlined),
                      label: 'Приоритет',
                      helperText: '',
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
                      Text('Назад'),
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
                      Text('Сохранить'),
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
        manHours: Provider.of<DiagnosticCardsNotifier>(context, listen: false).manHours
    );
    db.upgradeCard(_newCard);
  }
}
