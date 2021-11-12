import 'package:flutter/material.dart';

import 'logo.dart';

class ReportTitle extends StatelessWidget {
  final String name;

  const ReportTitle({
    Key? key,
    required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _titleStyle = TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold
    );
    final _subtitleStyle = TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w300
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 375.0),
          child: Logo(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 40.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('ООО «РусБурСервис»', style: _subtitleStyle,),
              Text('ИНН 6670196984, КПП 667001001', style: _subtitleStyle,),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(),
          child: Column(
            children: [
              Text('ОТЧЕТ ПО РЕЗУЛЬТАТАМ', style: _titleStyle,),
              Text('ДИАГНОСТИКИ БУРОВОГО СТАНКА', style: _titleStyle,),
              Text('№$name', style: _titleStyle,)
            ],
          ),
        )
      ],
    );
  }
}