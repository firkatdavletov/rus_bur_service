import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
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
                        leading: FutureBuilder(
                          future: _getPath(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> path) {
                            if (path.hasData) {
                              return Image.file(File('${path.data}/${snapshot.data[i].pictureFileName}.jpg'));
                            } else if (path.hasError) {
                              return Icon(Icons.error);
                            } else {
                              return Icon(Icons.access_alarm);
                            }
                          },
                        ),
                        title: Text(snapshot.data[i].name),
                        subtitle: Text(snapshot.data[i].description),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('?????????????? ?????????', textAlign: TextAlign.center,),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  db.deletePicture(snapshot.data[i].id);
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Text('????')),
                                          OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('????????????'))
                                        ],
                                      ),
                                    );
                                  });
                            });
                            String? path = await _getPath();
                            File('$path/${snapshot.data[i].pictureFileName}.jpg').delete();
                          },
                        ),
                        onTap: () async {
                          String? path = await _getPath();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreenPage(
                                      file: File('$path/${snapshot.data[i].pictureFileName}.jpg'),
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
            return Text('Snapshot error: ${snapshot.error}');
          } else {
            return WaitingPage();
          }
        }
    );
  }

  Future<String?> _getPath() async {
    String? path;
    final Directory directory = await getApplicationSupportDirectory();
    path = directory.path;
    return path;
  }
}

