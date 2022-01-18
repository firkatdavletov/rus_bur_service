import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/full_screen_picture_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';

import '../../main.dart';

class CardPicturesList extends StatefulWidget {
  const CardPicturesList({Key? key}) : super(key: key);

  @override
  _CardPicturesListState createState() => _CardPicturesListState();
}

class _CardPicturesListState extends State<CardPicturesList> {
  @override
  Widget build(BuildContext context) {
    int _reportId = Provider.of<ReportNotifier>(context, listen: false).id;
    String _cardId = Provider.of<DiagnosticCardsNotifier>(context, listen: false).id;
    return FutureBuilder(
        future: db.getPicture(_reportId, _cardId),
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

