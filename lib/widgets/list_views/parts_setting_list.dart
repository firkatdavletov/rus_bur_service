import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/operations_settings_page.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';

import '../../main.dart';

class PartsSettingList extends StatefulWidget {
  const PartsSettingList({Key? key}) : super(key: key);

  @override
  _PartsSettingListState createState() => _PartsSettingListState();
}

class _PartsSettingListState extends State<PartsSettingList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.getParts(),
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
                      db.deletePart(snapshot.data[i].id);
                    });
                  },
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OperationsSettingPage(partId: snapshot.data[i].id)
                      )
                  );
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
