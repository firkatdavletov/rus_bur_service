import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/models/card.dart';
import 'package:rus_bur_service/models/operation.dart';
import 'package:rus_bur_service/pages/diagnostic_cards_page.dart';
import 'package:rus_bur_service/widgets/drawers/app_drawer.dart';
import 'package:rus_bur_service/widgets/dropdown_menu.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:rus_bur_service/widgets/forms/text_form_field_report.dart';

import '../main.dart';

List<String> _resultList = ['УСПЕШНО', 'ВНИМАНИЕ', 'НЕУДАЧА'];
List<String> _priorotyList = ['РЕКОМЕНДУЕТСЯ', 'ПЛАНОВО', 'СРОЧНО'];
String conclusionValue = 'УСПЕШНО';
String priorityValue = 'РЕКОМЕНДУЕТСЯ';


class CardFillingPage extends StatefulWidget {
  final int partIndex;
  final int operationIndex;
  final int operationId;

  const CardFillingPage({
    Key? key,
    required this.partIndex,
    required this.operationIndex,
    required this.operationId
  }) : super(key: key);


  @override
  _CardFillingPageState createState() => _CardFillingPageState();
}

class _CardFillingPageState extends State<CardFillingPage> {
  final _inputTitleStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );
  final _inputSubtitleStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );



  @override
  Widget build(BuildContext context) {

    final String _name = '${widget.partIndex+1}-${widget.operationIndex+1}';

    TextEditingController _problemDescription = TextEditingController(
        text: ''
    );
    TextEditingController _areaCtrl = TextEditingController(
        text: ''
    );
    TextEditingController _damageCtrl = TextEditingController(
        text: ''
    );
    TextEditingController _recommendCtrl = TextEditingController(
        text: ''
    );
    TextEditingController _timeCtrl = TextEditingController(
        text: ''
    );
    TextEditingController _effectCtrl = TextEditingController(
        text: ''
    );
    TextEditingController _manHoursCtrl = TextEditingController(
        text: ''
    );



    return Scaffold(
      appBar: AppBar(
        title: Text('Диагностическая карта №$_name'),
      ),
      drawer: ReportDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Text('Диагностическая карта №$_name', style: _inputTitleStyle)
          ),
          FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return InputReportIntl(
                  labelText: 'Описание диагностической операции:',
                  maxLines: 1,
                  initialValue: snapshot.data.name
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error'),);
              } else {
                return Center(child: Text('Wait'),);
              }
            },
            future: db.getOperationById(widget.operationId),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Text('Заключение по результатам проверки:', style: _inputSubtitleStyle)
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  color: (conclusionValue == 'УСПЕШНО')?
                  Colors.lightGreenAccent :
                  (conclusionValue == 'ВНИМАНИЕ')?
                  Colors.yellow :
                  (conclusionValue == 'НЕУДАЧА')?
                  Colors.redAccent : null,
                  child: MyDropdownMenu(
                    list: _resultList,
                    dropdownValue: conclusionValue,
                    func: (String value) {
                      if (value == 'УСПЕШНО') {
                        print('ok');
                      }
                      setState(() {
                        conclusionValue = value;
                      });

                    },),
                ),
              )
            ],
          ),
          Visibility(
            visible: !(conclusionValue == 'УСПЕШНО'),
              child: InputReportCtrl(
                controller: _problemDescription,
                labelText: 'Описание проблемы',
                maxLines: 3,
                hintText: 'Напишите подробное описание проблемы',
              )
          ),
          // FutureBuilder(
          //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //     if (snapshot.hasData) {
          //       return InputReportIntl(
          //         labelText: 'Узел/система:',
          //         maxLines: 1,
          //         initialValue: snapshot.data
          //       );
          //     } else if (snapshot.hasError) {
          //       return Center(child: Text('Error'),);
          //     } else {
          //       return Center(child: Text('Wait'),);
          //     }
          //   },
          //   future: db.getPartNameByOperationId(widget.operationId),
          // ),
          InputReportCtrl(
              controller: _areaCtrl,
              hintText: 'Введите зону осмотра/выявления дефекта',
              labelText: 'Зона осмотра',
              maxLines: 3),
          InputReportCtrl(
            controller: _damageCtrl,
            hintText: 'Опишите вид повреждения',
            labelText: 'Вид повреждения',
            maxLines: 2,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Text('Приоритетность:', style: _inputTitleStyle)
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  color: (priorityValue == 'РЕКОМЕНДУЕТСЯ')?
                  Colors.lightGreenAccent :
                  (priorityValue == 'ПЛАНОВО')?
                  Colors.yellow :
                  (priorityValue == 'СРОЧНО')?
                  Colors.redAccent : null,
                  child: MyDropdownMenu(
                    list: _priorotyList,
                    dropdownValue: priorityValue,
                    func: (String value) {
                      setState(() {
                        priorityValue = value;
                      });

                    },),
                ),
              )
            ],
          ),
          InputReportCtrl(
            controller: _recommendCtrl,
            hintText: 'Напишите рекомендации',
            labelText: 'Рекомендуемые решения',
            maxLines: 2,
          ),
          InputReportCtrl(
            controller: _timeCtrl,
            hintText: 'Введите кол-во времени',
            labelText: 'Срок реализации',
            maxLines: 1,
          ),
          InputReportCtrl(
            controller: _effectCtrl,
            hintText: 'Например, снижение расходов',
            labelText: 'Риски/положительный эффект',
            maxLines: 3,
          ),
          InputReportCtrl(
            controller: _manHoursCtrl,
            hintText: 'Введите целое число',
            labelText: 'Количество чел./ч',
            maxLines: 1,
          ),
          ElevatedButton(
              onPressed: () {
                DiagnosticCard card = DiagnosticCard(
                    id: 0,
                    name: _name,
                    operationId: widget.operationId,
                    reportId: 0,
                    conclusion: conclusionValue,
                    description: _problemDescription.text,
                    area: _areaCtrl.text,
                    damage: _damageCtrl.text,
                    priority: priorityValue,
                    recommend: _recommendCtrl.text,
                    time: _timeCtrl.text,
                    effect: _effectCtrl.text,
                    manHours: int.parse(_manHoursCtrl.text)
                );
                context.read<DiagnosticCardsNotifier>().addCard(card);
              },
              child: Text('Добавить')
          )
        ],
      ),
    );
  }

}
