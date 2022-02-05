import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rus_bur_service/helpers/mail_sendler.dart';
import 'package:rus_bur_service/models/report.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/home_page.dart';
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
      future: PdfProvider().generate(report, context.read<UserNotifier>().user),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('PDF Viewer'),
            ),
            body: SfPdfViewer.file(snapshot.data),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.send),
              onPressed: () {
                MailSender(context: context).sendMail(
                    snapshot.data,
                    report
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage()
                    )
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return ErrorPage();
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
}


