import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:rus_bur_service/widgets/forms/create_report_form.dart';

import '../controller/user_notifier.dart';
import '../widgets/drawers/app_drawer.dart';

class ReportMainPage extends StatelessWidget {
  const ReportMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Данные заказчика'),
      ),
      drawer: AppDrawer(user: Provider.of<UserNotifier>(context, listen: false).user,),
      body: CreateReportForm(),
    );
  }
}
