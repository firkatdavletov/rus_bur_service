import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/full_screen_picture_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';

import '../../main.dart';

class ReportPicturesList extends StatefulWidget {
  const ReportPicturesList({Key? key}) : super(key: key);

  @override
  _ReportPicturesListState createState() => _ReportPicturesListState();
}

class _ReportPicturesListState extends State<ReportPicturesList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: db.getPicture(Provider.of<ReportNotifier>(context, listen: false).id, ''),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ListTile(
                        leading: Image.memory(snapshot.data[i].picture),
                        title: Text(snapshot.data[i].name),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              db.deletePicture(snapshot.data[i].id);
                            });
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreenPage(
                                      bytes: snapshot.data[i].picture,
                                      title: snapshot.data[i].name
                                  )
                              )
                          );
                        },
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      );
                    }
                )
            );
          } else if (snapshot.hasError) {
            return ErrorPage();
          } else {
            return WaitingPage();
          }
        }
    );
  }
}

