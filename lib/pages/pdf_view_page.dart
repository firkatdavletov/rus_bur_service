import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';

import 'package:rus_bur_service/helpers/mail_sendler.dart';
import 'package:rus_bur_service/models/report.dart';
import 'package:rus_bur_service/pages/home_page.dart';
import 'package:rus_bur_service/pages/machine_info_page.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controller/user_notifier.dart';
import '../helpers/pdf_provider.dart';


class PDFViewPage extends StatelessWidget {
  final Report report;
  const PDFViewPage({
    Key? key,
    required this.report
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getPDFFile(context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('PDF Viewer'),
            ),
            body: snapshot.data.isReady
                ? SfPdfViewer.file(File('${snapshot.data.filePath}'))
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Отчет не заполнен.'),
                        SizedBox(height: 20.0,),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ReportNotifier>().set(report);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MachineInfoPage()
                                  )
                              );
                            },
                            child: Text('Перейти к заполнению'))
                      ],
                    ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.send),
              onPressed: snapshot.data.isReady
                  ? () {
                          MailSender(context: context).sendMail(
                              report
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()
                              )
                          );
                        }
                  : null,
              ),
            );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, color: Colors.redAccent,),
                  SizedBox(height: 10.0,),
                  Text('Что-то пошло не так... '),
                  SizedBox(height: 10.0,),
                  Text('${snapshot.error}'),
                  SizedBox(height: 10.0,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()
                            )
                        );
                      },
                      child: Text('Вернуться на главную'))
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Создаю PDF-файл...', textAlign: TextAlign.center,),
                  Text('Это может занять несколько минут.', textAlign: TextAlign.center,),
                  SizedBox(
                    height: 20.0,
                  ),
                  CircularProgressIndicator.adaptive()
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<PdfData> _getPDFFile(BuildContext context) async {
    bool isReady = await PdfProvider().generate(report, context.read<UserNotifier>().user);
    if (isReady) {
      String? path;
      final Directory directory = await getApplicationSupportDirectory();
      path = directory.path;
      String filePath = '$path/report_pdf.pdf';
      PdfData pdfData = PdfData(filePath, isReady);
      return pdfData;
    } else {
      return PdfData('', isReady);
    }
  }
}

class PdfData {
  final String filePath;
  final bool isReady;

  PdfData(this.filePath, this.isReady);
}


