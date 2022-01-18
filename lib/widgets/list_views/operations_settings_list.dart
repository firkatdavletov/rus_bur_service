import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/operations_settings_page.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';

import '../../main.dart';

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
                      db.deleteOperation(snapshot.data[i].id);
                    });
                  },
                ),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => OperationsSettingPage(partId: snapshot.data[i].id)
                  //     )
                  // );
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