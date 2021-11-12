import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/pages/report_page3.dart';
import 'package:rus_bur_service/pages/diagnostic_cards_page.dart';
import 'package:rus_bur_service/widgets/drawers/app_drawer.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';

import 'package:rus_bur_service/widgets/forms/text_form_field_report.dart';

class ReportPage4 extends StatefulWidget {
  const ReportPage4({Key? key}) : super(key: key);

  @override
  _ReportPage4State createState() => _ReportPage4State();
}

class _ReportPage4State extends State<ReportPage4> {
  @override
  Widget build(BuildContext context) {

    TextEditingController _noteCtrl = TextEditingController(
      text: context.watch<ReportNotifier>().note
    );

    _saveData() {
      context.read<ReportNotifier>().changeNote(_noteCtrl.text);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Примечание'),
      ),
      drawer: ReportDrawer(),
      body: Container(
          child: ListView(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputReportCtrl(
                        controller: _noteCtrl,
                        hintText: 'Введите текст',
                        labelText: 'Примечание:',
                        maxLines: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              _saveData();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReportPage3()
                                  )
                              );
                            },
                            child: Text('Предыдущая страница')
                        ),
                        TextButton(
                            onPressed: () {
                              _saveData();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DiagnosticCardsPage()
                                  )
                              );
                            },
                            child: Text('Следующая страница')
                        ),
                      ],
                    )
                  ]
              ),
            ],
          )
      ),
    );
  }
}

