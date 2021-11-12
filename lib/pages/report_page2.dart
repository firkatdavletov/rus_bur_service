import 'package:flutter/material.dart';
import 'package:rus_bur_service/controller/customer_notifier.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/pages/report_page3.dart';
import 'package:rus_bur_service/widgets/label_input_rep.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:rus_bur_service/widgets/forms/text_form_field_report.dart';

class ReportPage2 extends StatelessWidget {
  const ReportPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController _placeCtrl = TextEditingController(
      text: context.watch<CustomerNotifier>().place
    );
    TextEditingController _customerFirstNameCtrl = TextEditingController(
      text: context.watch<CustomerNotifier>().customerFirstName
    );
    TextEditingController _customerLastNameCtrl = TextEditingController(
      text: context.watch<CustomerNotifier>().customerLastName
    );
    TextEditingController _customerMiddleNameCtrl = TextEditingController(
      text: context.watch<CustomerNotifier>().customerMiddleName
    );
    TextEditingController _customerPhoneCtrl = TextEditingController(
      text: context.watch<CustomerNotifier>().customerPhone
    );
    TextEditingController _customerEmailCtrl = TextEditingController(
      text: context.watch<CustomerNotifier>().customerEmail
    );

    _saveData() {
      context.read<CustomerNotifier>().changePlace(_placeCtrl.text);
      context.read<CustomerNotifier>().changeFirstName(_customerFirstNameCtrl.text);
      context.read<CustomerNotifier>().changeLastName(_customerLastNameCtrl.text);
      context.read<CustomerNotifier>().changeMiddleName(_customerMiddleNameCtrl.text);
      context.read<CustomerNotifier>().changePhone(_customerPhoneCtrl.text);
      context.read<CustomerNotifier>().changeEmail(_customerEmailCtrl.text);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Данные заказчика'),
      ),
      drawer: ReportDrawer(),
      body: Container(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelInputReport(label: 'Данные заказчика:',),
                InputReportIntl(
                  labelText: 'Заказчик:',
                  initialValue: context.watch<CustomerNotifier>().companyName,
                ),
                InputReportCtrl(
                    labelText: 'Место проведения работ:',
                    controller: _placeCtrl,
                    hintText: 'например, пос. Вишнёвогорск',
                    maxLines: 1,
                ),
                LabelInputReport(label: 'Контактное лицо заказчика:'),
                InputReportCtrl(
                    labelText: 'Фамилия:',
                    controller: _customerLastNameCtrl,
                    hintText: 'Введите фамилию',
                    maxLines: 1,
                ),
                InputReportCtrl(
                    labelText: 'Имя:',
                    controller: _customerFirstNameCtrl,
                    hintText: 'Введите имя',
                    maxLines: 1,
                ),
                InputReportCtrl(
                  controller: _customerMiddleNameCtrl,
                  hintText: 'Введите отчество:',
                  labelText: 'Отчество:',
                  maxLines: 1,
                ),
                InputReportCtrl(
                    labelText: 'Контактный телефон:',
                    controller: _customerPhoneCtrl,
                    hintText: 'Введите номер телефона',
                    maxLines: 1,
                ),
                InputReportCtrl(
                    labelText: 'Email:',
                    controller: _customerEmailCtrl,
                    hintText: 'Напишите электронную почту заказчика',
                    maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {

                        },
                        child: Text('Предыдущая страница')
                    ),
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
