import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/widgets/drawers/app_drawer.dart';
import 'package:rus_bur_service/widgets/list_views/report_list_view.dart';
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
        appBar: AppBar(
          title: Text('Главная страница'),
        ),
        drawer: AppDrawer(user: _user),
        body: Container(
          child: ReportListView()
        ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read<ReportNotifier>().changeReportState(true);
            DateTime now = DateTime.now();
            context.read<ReportNotifier>().changeDate('${now.day}/${now.month}/${now.year}');
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
