import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:rus_bur_service/widgets/forms/machine_info_form.dart';

class MachineInfoPage extends StatelessWidget {
  const MachineInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double _height = MediaQuery.of(context).size.height - 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('Данные машины'),
      ),
      drawer: ReportDrawer(),
      body: MachineInfoForm()
    );
  }
}