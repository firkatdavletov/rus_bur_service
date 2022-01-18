import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/models/diagnostic_card.dart';
import 'package:rus_bur_service/pages/create_card_page.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';

import '../../main.dart';

class CardsList extends StatefulWidget {
  const CardsList({Key? key}) : super(key: key);

  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: db.getCards(Provider.of<ReportNotifier>(context, listen: false).id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(snapshot.data[i].name),
                    subtitle: Text(snapshot.data[i].area),
                    leading: Icon(
                        Icons.check_circle,
                        color: snapshot.data[i].priority == 1
                            ? Colors.lightGreen
                            : snapshot.data[i].priority == 2
                            ? Colors.orangeAccent
                            : snapshot.data[i].priority == 3
                            ? Colors.redAccent
                            : snapshot.data[i].priority == 0
                            ? Colors.grey
                            : null
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            db.deleteCard(snapshot.data[i].id);
                          });
                        }
                    ),
                    onTap: () {
                      context.read<DiagnosticCardsNotifier>().changeId(snapshot.data[i].id);
                      context.read<DiagnosticCardsNotifier>().changeName(snapshot.data[i].name);
                      context.read<DiagnosticCardsNotifier>().changeOperationId(snapshot.data[i].operationId);
                      context.read<DiagnosticCardsNotifier>().changeReportId(snapshot.data[i].reportId);
                      context.read<DiagnosticCardsNotifier>().changeArea(snapshot.data[i].area);
                      context.read<DiagnosticCardsNotifier>().changeConclusion(snapshot.data[i].conclusion);
                      context.read<DiagnosticCardsNotifier>().changeDescription(snapshot.data[i].description);
                      context.read<DiagnosticCardsNotifier>().changeDamage(snapshot.data[i].damage);
                      context.read<DiagnosticCardsNotifier>().changePriority(snapshot.data[i].priority);
                      context.read<DiagnosticCardsNotifier>().changeRecommend(snapshot.data[i].recommend);
                      context.read<DiagnosticCardsNotifier>().changeTime(snapshot.data[i].time);
                      context.read<DiagnosticCardsNotifier>().changeEffect(snapshot.data[i].effect);
                      context.read<DiagnosticCardsNotifier>().changeManHours(snapshot.data[i].manHours);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateCardPage()
                          )
                      );
                    },
                  );
                }
            );
          } else if (snapshot.hasError) {
            print('snapshot error: ${snapshot.error}');
            return ErrorPage();
          } else {
            return WaitingPage();
          }
        }
    );
  }
}
