import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/pages/agreed_diagnostic_areas_page.dart';
import 'package:rus_bur_service/widgets/appbar/app_bar.dart';
import 'package:rus_bur_service/widgets/list_views/cards_list.dart';

import '../controller/user_notifier.dart';
import '../widgets/drawers/app_drawer.dart';
import 'home_page.dart';

class AgreedDiagnosticCardsPage extends StatelessWidget {
  const AgreedDiagnosticCardsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppBar('Диагностические карты'),
      drawer: AppDrawer(user: Provider.of<UserNotifier>(context, listen: false).user,),
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
                child: ElevatedButton (
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
                child: ElevatedButton (
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
