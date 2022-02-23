import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/widgets/appbar/app_bar.dart';
import 'package:rus_bur_service/widgets/drawers/app_drawer.dart';
import 'package:rus_bur_service/widgets/list_views/report_list_view.dart';
import '../main.dart';
import 'report_main_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User _user = context.watch<UserNotifier>().user;
    return Scaffold(
        appBar: myAppBar('Главная страница'),
        drawer: AppDrawer(user: _user),
        body: FutureBuilder(
          future: db.reports(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ReportListView(reports: snapshot.data,);
            } else if (snapshot.hasError) {
              print('snapshot error: ${snapshot.error}');
              return Center(
                child: Text('Ошибка получения данных'),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10.0,),
                    Text('Составляю список отчетов... ')
                  ],
                ),
              );
            }
          },
        ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.lightBlueAccent,
          onPressed: () {
            context.read<ReportNotifier>().reset();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportMainPage()
                )
            );
          },
          label: Text('Создать'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
