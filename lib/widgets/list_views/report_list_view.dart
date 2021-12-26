import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/models/report.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';

import '../../helpers/excel_provider.dart';
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
              child: Text('Нет отчётов. Нажите Создать для создания первого отчёта'),
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
                      onPressed: () {
                        User _user = context.read<UserNotifier>().user;
                        ExcelProvider(context: context).generateExcel(snapshot.data[i], _user);
                      },
                      icon: Icon(Icons.send),
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
                                              // _decrementReportsCount();
                                              // _decrementUserReportsCount(
                                              //     Provider.of<UserNotifier>(context, listen: false).user.userId
                                              // );
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
                  context.read<ReportNotifier>().changeReportState(false);
                  context.read<ReportNotifier>().changeName(snapshot.data[i].name);
                  context.read<ReportNotifier>().changeReportId(snapshot.data[i].id);
                  context.read<ReportNotifier>().changeUserId(snapshot.data[i].userId);
                  context.read<ReportNotifier>().changeCompany(snapshot.data[i].company);
                  context.read<ReportNotifier>().changeDate(snapshot.data[i].date);
                  context.read<ReportNotifier>().changePlace(snapshot.data[i].place);
                  context.read<ReportNotifier>().changeCustomerName(snapshot.data[i].customerName);
                  context.read<ReportNotifier>().changeCustomerPhone(snapshot.data[i].customerPhone);
                  context.read<ReportNotifier>().changeCustomerEmail(snapshot.data[i].customerEmail);
                  context.read<ReportNotifier>().changeMachineModel(snapshot.data[i].machineModel);
                  context.read<ReportNotifier>().changeMachineNumb(snapshot.data[i].machineNumb);
                  context.read<ReportNotifier>().changeMachineYear(snapshot.data[i].machineYear);
                  context.read<ReportNotifier>().changeEngineModel(snapshot.data[i].engineModel);
                  context.read<ReportNotifier>().changeEngineNumb(snapshot.data[i].engineNumb);
                  context.read<ReportNotifier>().changeOpTime_1(snapshot.data[i].opTime_1);
                  context.read<ReportNotifier>().changeOpTime_2(snapshot.data[i].opTime_2);
                  context.read<ReportNotifier>().changeOpTime_3(snapshot.data[i].opTime_3);
                  context.read<ReportNotifier>().changeNote(snapshot.data[i].note);
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
          return Text('Получение данных ');
        }
      },
    );
  }
}

