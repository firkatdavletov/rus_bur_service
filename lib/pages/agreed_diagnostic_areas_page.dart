import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:rus_bur_service/widgets/list_views/parts_list.dart';

class AgreedDiagnosticAreas extends StatelessWidget {
  const AgreedDiagnosticAreas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Согласование направлений диагностики'),
      ),
      drawer: ReportDrawer(),
      body: PartsList(),
    );
  }
}


