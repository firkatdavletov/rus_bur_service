import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/helpers/mail_sendler.dart';
import 'package:rus_bur_service/helpers/pdf_provider.dart';
import 'package:rus_bur_service/helpers/file_provider.dart';
import 'package:rus_bur_service/models/report.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/pages/pdf_view_page.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';
import 'dart:io';

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
                          File _pdfFile = await PdfProvider().generate(snapshot.data[i]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PDFViewPage(file: _pdfFile,)
                              )
                          );
                        },
                        icon: Icon(Icons.picture_as_pdf)
                    ),
                    IconButton(
                      onPressed: () async {
                        User _user = context.read<UserNotifier>().user;
                        final excelFile = await ExcelProvider(context: context)
                            .generateExcel(snapshot.data[i], _user);
                        FileProvider().save(excelFile, 'reportnew.xlsx');
                        print('ExcelProvider: created file');
                        MailSender(context: context)
                            .sendMail('reportnew.xlsx', snapshot.data[i].id);
                        FileProvider().delete('reportnew.xlsx');
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

