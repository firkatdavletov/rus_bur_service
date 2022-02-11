import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/models/agreed_part.dart';
import 'package:rus_bur_service/models/diagnostic_card.dart';
import 'package:rus_bur_service/models/operation.dart';
import 'package:rus_bur_service/models/part.dart';
import 'package:rus_bur_service/pages/agreed_diagnostic_cards_page.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/pictures_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';

import '../../main.dart';

class PartsList extends StatefulWidget {
  const PartsList({Key? key}) : super(key: key);

  @override
  _PartsListState createState() => _PartsListState();
}

class _PartsListState extends State<PartsList> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    int _reportId = Provider.of<ReportNotifier>(context, listen: false).id;
    return FutureBuilder(
        future: db.getCheckedParts(_reportId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, int i) {
                          return ListTile(
                            title: Text(snapshot.data[i].name),
                            trailing: Checkbox(
                              checkColor: Colors.white,
                              value: snapshot.data[i].isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  AgreedPart _agreedPart = AgreedPart(
                                      reportId: _reportId,
                                      partId: snapshot.data[i].id
                                  );
                                  if (value!) {
                                    db.insertAgreedPart(_agreedPart);
                                  } else if (!value) {
                                    db.deleteAgreedPart(_agreedPart);
                                  }
                                });
                              },
                            ),
                          );
                        }
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: OutlinedButton (
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PicturesPage()
                                )
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back_ios),
                              Container(width: 5,),
                              _width > 400
                                  ? Text('Фотографии')
                                  : Text(''),
                            ],
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: OutlinedButton (
                          onPressed: () async {
                            for (Part p in snapshot.data) {
                              if (p.isChecked) {
                                var _operations = await db.getOperations('part_id', p.id);
                                for (Operation op in _operations) {
                                  DiagnosticCard _card = DiagnosticCard(
                                      id: '$_reportId-${p.id}-${op.id}',
                                      name: op.name,
                                      operationId: op.id,
                                      reportId: _reportId,
                                      conclusion: 1,
                                      description: '',
                                      area: '',
                                      damage: '',
                                      priority: 1,
                                      recommend: '',
                                      termWeek: 0,
                                      term_bh: 0,
                                      term_m: 0,
                                      term_mh: 0,
                                      effect: '',
                                      manHours: 0,
                                      part: p.name,
                                      status: 0
                                  );
                                  db.insertCard(_card);
                                }
                              }
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new AgreedDiagnosticCardsPage()
                                )
                            );
                          },
                          child: Row(
                            children: [
                              _width > 400
                                  ? Text('Диагностические карты')
                                  : Text(''),
                              Container(width: 5,),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          )
                      ),
                    )
                  ],
                )
              ],
            );
          } else if (snapshot.hasError) {
            return ErrorPage();
          } else {
            return WaitingPage();
          }
        });
  }
}

