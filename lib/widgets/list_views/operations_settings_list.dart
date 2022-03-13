import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/operation_notifier.dart';
import 'package:rus_bur_service/pages/operations_settings_page.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';

import '../../main.dart';
import '../alert_dialog/operation_edit_alert_dialog.dart';

class OperationsSettingList extends StatefulWidget {
  final int partId;
  const OperationsSettingList({
    Key? key,
    required this.partId
  }) : super(key: key);

  @override
  _OperationsSettingListState createState() => _OperationsSettingListState();
}

class _OperationsSettingListState extends State<OperationsSettingList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.getOperations('part_id', widget.partId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int i) {
              return ListTile(
                title: Text(snapshot.data[i].name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Удалить операцию?', textAlign: TextAlign.center,),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          db.deleteOperation(snapshot.data[i].id);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: Text('Да')),
                                  OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Отмена'))
                                ],
                              ),
                            );
                          });
                    });
                  },
                ),
                onTap: () {
                  context.read<OperationNotifier>().setOperation(snapshot.data[i]);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Редактирование', textAlign: TextAlign.center,),
                          content: OperationEditAlertDialog(isNew: false),
                        );
                      });
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return ErrorPage();
        } else {
          return WaitingPage();
        }
      },
    );
  }
}
