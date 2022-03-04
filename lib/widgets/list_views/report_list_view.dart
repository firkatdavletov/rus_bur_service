import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/pages/pdf_view_page.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';
import '../../controller/user_notifier.dart';
import '../../main.dart';

class ReportListView extends StatefulWidget {
  final int userId;
  const ReportListView({
    Key? key,
    required this.userId
  }) : super(key: key);

  @override
  _ReportListViewState createState() => _ReportListViewState();
}

class _ReportListViewState extends State<ReportListView> {

  @override
  Widget build(BuildContext context) {
    bool _isAdmin = context.watch<UserNotifier>().user.isAdmin;
    return FutureBuilder(
      future: _isAdmin? db.readReports() : db.readReportsToUser(widget.userId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int i) {
              double space = 20.0;
              return ExpansionTile(
                  leading: Text('${snapshot.data[i].name}'),
                  title: Text('${snapshot.data[i].company}'),
                  subtitle: Text('Машина : ${snapshot.data[i].machineModel} дата: ${snapshot.data[i].date} user ID: ${snapshot.data[i].userId}'),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              context.read<ReportNotifier>().set(snapshot.data[i]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReportMainPage()
                                  )
                              );
                            },
                            child: Text('Редактировать')
                        ),
                        SizedBox(width: space,),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ReportNotifier>().set(snapshot.data[i]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PDFViewPage(report: snapshot.data[i],)
                                  )
                              );
                            },
                            child: Text('Отправить')
                        ),
                        SizedBox(width: space,),
                        OutlinedButton(
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
                                                  db.deletePictures(snapshot.data[i].id);
                                                  db.deleteReport(snapshot.data[i].id);
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
                            child: Text('Удалить')
                        ),
                      ],
                    ),
                    SizedBox(height: space,)
                  ],
              );
              // return ListTile(
              //   leading: Text('${snapshot.data[i].name}'),
              //   title: Text('${snapshot.data[i].company}'),
              //   subtitle: Text('Машина : ${snapshot.data[i].machineModel} дата: ${snapshot.data[i].date}'),
              //   trailing: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       IconButton(
              //           onPressed: () async {
              //             context.read<ReportNotifier>().set(snapshot.data[i]);
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => PDFViewPage(report: snapshot.data[i],)
              //                 )
              //             );
              //           },
              //           icon: Icon(Icons.send)
              //       ),
              //       IconButton(
              //           onPressed: () {
              //             showDialog(
              //                 context: context,
              //                 builder: (BuildContext context) {
              //                   return AlertDialog(
              //                     title: Text('Удалить отчёт?', textAlign: TextAlign.center,),
              //                     content: Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                       children: [
              //                         ElevatedButton(
              //                             onPressed: () {
              //                               setState(() {
              //                                 db.deletePictures(snapshot.data[i].id);
              //                                 db.deleteReport(snapshot.data[i].id);
              //                                 Navigator.of(context).pop();
              //                               });
              //                             },
              //                             child: Text('Да')),
              //                         OutlinedButton(
              //                             onPressed: () {
              //                               Navigator.of(context).pop();
              //                             },
              //                             child: Text('Отмена'))
              //                       ],
              //                     ),
              //                   );
              //                 });
              //           },
              //           icon: Icon(Icons.delete))
              //     ],
              //   ),
              //   onTap: () {
              //     context.read<ReportNotifier>().set(snapshot.data[i]);
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => ReportMainPage()
              //         )
              //     );
              //   },
              //   onLongPress: () {},
              // );
            },
          );
        } else if (snapshot.hasError) {
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

