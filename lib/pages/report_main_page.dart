import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/widgets/appbar/app_bar.dart';
import 'package:rus_bur_service/widgets/forms/create_report_form.dart';

import '../controller/user_notifier.dart';
import '../widgets/drawers/app_drawer.dart';

class ReportMainPage extends StatelessWidget {
  const ReportMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Данные заказчика'),
      drawer: AppDrawer(user: Provider.of<UserNotifier>(context, listen: false).user,),
      body: CreateReportForm(),
    );
  }
}
