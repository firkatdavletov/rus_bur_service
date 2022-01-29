import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/agreed_diagnostic_areas_page.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:rus_bur_service/widgets/list_views/cards_list.dart';

import 'home_page.dart';

class AgreedDiagnosticCardsPage extends StatelessWidget {
  const AgreedDiagnosticCardsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Диагностические карты'),
      ),
      drawer: ReportDrawer(),
      body: Column(
        children: [
          Expanded(
              child: CardsList()
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: OutlinedButton (
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgreedDiagnosticAreas()
                          )
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios),
                        Container(width: 5,),
                        _width > 400
                            ? Text('Выбрать области')
                            : Text(''),
                      ],
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: OutlinedButton (
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()
                          )
                      );
                    },
                    child: Row(
                      children: [
                        _width > 400
                            ? Text('Главная страница')
                            : Text(''),
                        Container(width: 5,),
                        Icon(Icons.home)
                      ],
                    )
                ),
              )
            ],
          )
        ]
      )
    );
  }
}
