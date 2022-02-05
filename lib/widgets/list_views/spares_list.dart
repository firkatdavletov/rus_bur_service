import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/controller/spare_notifier.dart';
import 'package:rus_bur_service/pages/add_spare_page.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';
import '../../main.dart';

class SparesList extends StatefulWidget {
  const SparesList({
    Key? key
  }) : super(key: key);

  @override
  _SparesListState createState() => _SparesListState();
}

class _SparesListState extends State<SparesList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.getSpare(Provider.of<DiagnosticCardsNotifier>(context, listen: false).id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(snapshot.data[i].name),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        db.deleteSpare(snapshot.data[i].id);
                      });
                    },
                  ),
                  leading: Icon(
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
                  onTap: () {
                    context.read<SpareNotifier>().changeIssue(snapshot.data[i].issue);
                    context.read<SpareNotifier>().changeNumber(snapshot.data[i].number);
                    context.read<SpareNotifier>().changeName(snapshot.data[i].name);
                    context.read<SpareNotifier>().changeQuantity(snapshot.data[i].quantity);
                    context.read<SpareNotifier>().changeMeasure(snapshot.data[i].measure);
                    context.read<SpareNotifier>().changePriority(snapshot.data[i].priority);
                    context.read<SpareNotifier>().changeId(snapshot.data[i].id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddSparePage(isNewSpare: false,)
                        )
                    );
                  },
                );
              });
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return ErrorPage();
        } else {
          return WaitingPage();
        }
      },
    );
  }
}
