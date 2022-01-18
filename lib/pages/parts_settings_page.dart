import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/settings_page.dart';
import 'package:rus_bur_service/widgets/alert_dialog/part_add_alert_dialog.dart';

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
                  return AlertDialog(
                    title: Text('Новый узел'),
                    content: PartAddAlertDialog(),
                  );
                });
          });
        },
      ),

    );
  }
}

