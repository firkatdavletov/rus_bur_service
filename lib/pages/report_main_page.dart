import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/buttons/app_outlined_button.dart';
import 'package:rus_bur_service/widgets/forms/app_text_form_field.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:rus_bur_service/widgets/forms/create_report_form.dart';

class ReportMainPage extends StatelessWidget {
  const ReportMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Данные заказчика'),
      ),
      drawer: ReportDrawer(),
      body: ListView(
        children: [
          CreateReportForm()
        ],
      ),
    );
  }
}
