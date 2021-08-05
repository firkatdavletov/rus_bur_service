import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateReport extends StatefulWidget {
  const CreateReport({Key? key}) : super(key: key);

  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание отчёта'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
