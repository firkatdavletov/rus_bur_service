import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/parts_settings_page.dart';
import 'package:rus_bur_service/widgets/alert_dialog/operation_add_alert_dialog.dart';
import 'package:rus_bur_service/widgets/list_views/operations_settings_list.dart';

class OperationsSettingPage extends StatefulWidget {
  final int partId;
  const OperationsSettingPage({
    Key? key,
    required this.partId
  }) : super(key: key);

  @override
  _OperationsSettingPageState createState() => _OperationsSettingPageState();
}

class _OperationsSettingPageState extends State<OperationsSettingPage> {
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
                    builder: (context) => PartsSettingPage()
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
      body: OperationsSettingList(partId: widget.partId),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Добавить'),
        onPressed: () {
          setState(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Новая операция'),
                    content: OperationAddAlertDialog(partId: widget.partId,),
                  );
                });
          });
        },
      ),

    );
  }
}

