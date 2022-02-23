import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rus_bur_service/api/google_sign_in_api.dart';
import 'package:rus_bur_service/helpers/htmlMailPage.dart';
import 'package:rus_bur_service/models/report.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MailSender {
  final BuildContext context;

  MailSender({
    required this.context
  });

  Future<bool> sendMail(Report report) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? path;
    final Directory directory = await getApplicationSupportDirectory();
    path = directory.path;

    final user = await GoogleAuthApi.signIn();

    if (user == null) {
      showSnackBar('Ошибка авторизации');
      GoogleAuthApi.signOut();
      return false;
    }

    String? mailAddress = prefs.getString('source_email');
    List<String>? recipients = prefs.getStringList('recipients_email');

    final auth = await user.authentication;
    final token = auth.accessToken!;

    print('Authenticated: $mailAddress');

    final smtpServer = gmailSaslXoauth2(mailAddress!, token);

    final message = Message()
      ..from = Address(mailAddress, 'ООО "РусБурСервис"')
      ..recipients = recipients!
      ..subject = 'Отчет по результатам диагностики бурового станка №${report.name} от ${report.date}'
      //..text = prefs.getString('text')
      ..html = HtmlMailPage(report: report).html()
      ..attachments = [
        FileAttachment(File('$path/report_pdf.pdf'))
        ..location = Location.attachment
      ];

    try {
      showSnackBar('Отправка отчета...');
      await send(message, smtpServer);
      showSnackBar('Отчет отправлен успешно!');
      return true;
    } on MailerException catch (e) {
      showSnackBar('$e');
      return false;
    }
  }


  void showSnackBar (String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.green,
    );
    print(text);
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}