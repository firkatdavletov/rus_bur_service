import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/part_notifier.dart';
import 'package:rus_bur_service/pages/settings_page.dart';
import 'package:rus_bur_service/widgets/alert_dialog/part_edit_alert_dialog.dart';

import 'package:rus_bur_service/widgets/list_views/parts_setting_list.dart';

class PartsSettingPage extends StatefulWidget {
  const PartsSettingPage({Key? key}) : super(key: key);

  @override
  _PartsSettingPageState createState() => _PartsSettingPageState();
}

class _PartsSettingPageState extends State<PartsSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Редактирование диагностических карт'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage()
                  )
              );
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blueGrey, Colors.lightBlueAccent]
                )
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))
          ),
        ),
        body: PartsSettingList(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Добавить'),
        onPressed: () {
          setState(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  context.read<PartNotifier>().changeName('');
                  return AlertDialog(
                    title: Text('Новый узел', textAlign: TextAlign.center,),
                    content: PartAddAlertDialog(),
                  );
                });
          });
        },
      ),

    );
  }
}

