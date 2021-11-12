import 'package:flutter/material.dart';
import 'package:rus_bur_service/controller/customer_notifier.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/machine_notifier.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/pages/report_page2.dart';
import 'package:rus_bur_service/pages/report_page4.dart';
import 'package:rus_bur_service/widgets/drawers/app_drawer.dart';
import 'package:rus_bur_service/widgets/dropdown_menu.dart';
import 'package:rus_bur_service/widgets/label_input_rep.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:rus_bur_service/widgets/forms/text_form_field_report.dart';

class ReportPage3 extends StatelessWidget {
  const ReportPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _machineModelCtrl = TextEditingController(
      text: context.watch<MachineNotifier>().model
    );
    TextEditingController _machineSNCtrl = TextEditingController(
        text: context.watch<MachineNotifier>().serialNumb
    );
    TextEditingController _machineYearCtrl = TextEditingController(
        text: context.watch<MachineNotifier>().year
    );
    TextEditingController _engineModelCtrl = TextEditingController(
        text: context.watch<MachineNotifier>().engineModel
    );
    TextEditingController _engineSNCtrl = TextEditingController(
        text: context.watch<MachineNotifier>().engineSN
    );
    TextEditingController _opTimeCtrl = TextEditingController(
        text: context.watch<MachineNotifier>().opTime
    );

    _saveData() {
      context.read<MachineNotifier>().changeModel(_machineModelCtrl.text);
      context.read<MachineNotifier>().changeSerialNumb(_machineSNCtrl.text);
      context.read<MachineNotifier>().changeYear(_machineYearCtrl.text);
      context.read<MachineNotifier>().changeEngineModel(_engineModelCtrl.text);
      context.read<MachineNotifier>().changeEngineSN(_engineSNCtrl.text);
      context.read<MachineNotifier>().changeOpTime(_opTimeCtrl.text);
    }

    _saveUnit(String value) {
      _saveData();
      context.read<MachineNotifier>().changeOpTimeUnit(value);
    }

    List<String> _list = <String>['м/ч', 'уд/ч', 'пог.м'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Данные машины'),
      ),
      drawer: ReportDrawer(),
      body: Container(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelInputReport(label: 'Данные машины:'),
                  InputReportCtrl(
                      labelText: 'Модель машины:',
                      controller: _machineModelCtrl,
                      hintText: 'Введите модель машины',
                      maxLines: 1,
                  ),
                  InputReportCtrl(
                      labelText: 'Серийный номер машины:',
                      controller: _machineSNCtrl,
                      hintText: 'Введите серийный номер машины',
                      maxLines: 1,
                  ),
                  InputReportCtrl(
                      labelText: 'Год выпуска машины:',
                      controller: _machineYearCtrl,
                      hintText: '',
                      maxLines: 1,
                  ),
                  InputReportCtrl(
                      labelText: 'Модель двигателя:',
                      controller: _engineModelCtrl, hintText: '',
                      maxLines: 1,
                  ),
                  InputReportCtrl(
                      labelText: 'Серийный номер двигателя:',
                      controller: _engineSNCtrl, hintText: '',
                      maxLines: 1,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: InputReportCtrl(
                              labelText: 'Наработка:',
                              controller: _opTimeCtrl, hintText: '',
                              maxLines: 1,
                          ),
                          flex: 5,
                      ),
                      Expanded(
                          child: MyDropdownMenu(
                            list: _list,
                            dropdownValue: context.watch<MachineNotifier>().opTimeUnit,
                            func: _saveUnit,
                          ),
                          flex: 1,
                      )
                    ],
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
                                    builder: (context) => ReportPage2()
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
                                    builder: (context) => ReportPage4()
                                )
                            );
                          },
                          child: Text('Следующая страница')
                      ),
                    ],
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}
