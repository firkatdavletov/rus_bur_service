import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/pages/create_card_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';

import '../../main.dart';
import '../../models/status.dart';

class CardsList extends StatefulWidget {
  const CardsList({Key? key}) : super(key: key);

  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  Status status = Status();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: db.getAllCards(Provider.of<ReportNotifier>(context, listen: false).id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  bool cardIsFilled = true;
                  if (snapshot.data[i].conclusion != 1
                      && (snapshot.data[i].description == ''
                          || snapshot.data[i].area == null
                          || (snapshot.data[i].damage == ''
                              && snapshot.data[i].status&status.status1 != status.status1
                              && snapshot.data[i].status&status.status2 != status.status2
                              && snapshot.data[i].status&status.status3 != status.status3
                              && snapshot.data[i].status&status.status4 != status.status4
                              && snapshot.data[i].status&status.status5 != status.status5))) {
                    cardIsFilled = false;
                  } else if (snapshot.data[i].effect == ''
                      && snapshot.data[i].status&status.status6 != status.status6
                      && snapshot.data[i].status&status.status7 != status.status7
                      && snapshot.data[i].status&status.status8 != status.status8
                      && snapshot.data[i].status&status.status9 != status.status9
                      && snapshot.data[i].status&status.status10 != status.status10) {
                    cardIsFilled = false;
                  } else if (snapshot.data[i].recommend == ''
                      && snapshot.data[i].status&status.status11 != status.status11
                      && snapshot.data[i].status&status.status12 != status.status12
                      && snapshot.data[i].status&status.status13 != status.status13
                      && snapshot.data[i].status&status.status14 != status.status14
                      && snapshot.data[i].status&status.status15 != status.status15) {
                    cardIsFilled = false;
                  }

                  return ListTile(
                    title: Text(snapshot.data[i].name),
                    subtitle: cardIsFilled
                        ? Text('Заполнено', style: TextStyle(color: Colors.green))
                          : Text('Не заполнено', style: TextStyle(color: Colors.redAccent)),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                            Icons.filter_1_rounded,
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
                        Icon(
                            Icons.check_circle,
                            color: snapshot.data[i].conclusion == 1
                                ? Colors.lightGreen
                                : snapshot.data[i].conclusion == 2
                                ? Colors.orangeAccent
                                : snapshot.data[i].conclusion == 3
                                ? Colors.redAccent
                                : snapshot.data[i].conclusion == 0
                                ? Colors.grey
                                : null
                        )
                      ],
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
                      context.read<DiagnosticCardsNotifier>().changeTermWeek(snapshot.data[i].termWeek);
                      context.read<DiagnosticCardsNotifier>().changeEffect(snapshot.data[i].effect);
                      context.read<DiagnosticCardsNotifier>().changeManHours(snapshot.data[i].manHours);
                      context.read<DiagnosticCardsNotifier>().changePart(snapshot.data[i].part);
                      context.read<DiagnosticCardsNotifier>().changeStatus(snapshot.data[i].status);
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
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, color: Colors.amber,),
                  SizedBox(height: 20.0,),
                  Text('Что-то пошло не так...\n\nError: ${snapshot.error}', textAlign: TextAlign.center,)
                ],
              ),
            );
          } else {
            return WaitingPage();
          }
        }
    );
  }
}
