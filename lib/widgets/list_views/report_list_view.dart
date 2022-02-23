import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/pages/pdf_view_page.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';
import '../../main.dart';
import '../../models/report.dart';

class ReportListView extends StatefulWidget {
  final List<Report> reports;
  const ReportListView({
    Key? key,
    required this.reports
  }) : super(key: key);

  @override
  _ReportListViewState createState() => _ReportListViewState();
}

class _ReportListViewState extends State<ReportListView> {
  List<Report> get _reports => widget.reports;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _reports.length,
      itemBuilder: (context, int i) {
        return ListTile(
          leading: Text('${_reports[i].name}'),
          title: Text('${_reports[i].company}'),
          subtitle: Text('${_reports[i].date}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PDFViewPage(report: _reports[i],)
                        )
                    );
                  },
                  icon: Icon(Icons.send)
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Удалить отчёт?', textAlign: TextAlign.center,),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _reports.removeAt(i);
                                        db.deleteReport(_reports[i].id);
                                        db.deletePictures(_reports[i].id);
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
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          onTap: () {
            context.read<ReportNotifier>().set(_reports[i]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportMainPage()
                )
            );
          },
          onLongPress: () {},
        );
      },
    );
  }
}

