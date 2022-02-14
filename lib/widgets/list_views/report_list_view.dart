import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/models/report.dart';
import 'package:rus_bur_service/pages/pdf_view_page.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';
import '../../main.dart';

class ReportListView extends StatefulWidget {
  const ReportListView({Key? key}) : super(key: key);

  @override
  _ReportListViewState createState() => _ReportListViewState();
}

class _ReportListViewState extends State<ReportListView> {
  Future<List<Report>> _getReportItem() {
    return db.reports();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getReportItem(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data.length == 0) {
            return Center(
              child: Text('Пока тут пусто'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int i) {
              return ListTile(
                leading: Text('${snapshot.data[i].name}'),
                title: Text('${snapshot.data[i].company}'),
                subtitle: Text('${snapshot.data[i].date}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PDFViewPage(report: snapshot.data[i],)
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
                                  title: Text('Удалить отчёт?'),
                                  content: Row(
                                    children: [
                                      OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              db.deleteReport(snapshot.data[i].id);
                                              db.deletePictures(snapshot.data[i].id);
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: Text('Да')),
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Нет'))
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
                onTap: () {
                  context.read<ReportNotifier>().set(snapshot.data[i]);
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
        } else if (snapshot.hasError) {
          print('snapshot error: ${snapshot.error}');
          return Center(
            child: Text('Ошибка получения данных'),
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10.0,),
                Text('Составляю список отчетов... ')
              ],
            ),
          );
        }
      },
    );
  }
}

