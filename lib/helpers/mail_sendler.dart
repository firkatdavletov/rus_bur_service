import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:rus_bur_service/api/google_sign_in_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class MailSender {
  final BuildContext context;

  MailSender({
    required this.context
  });

  Future<void> sendMail(String fileName, int reportId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory =
      await path_provider.getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }

    // File _file = File('$path/$fileName');
    // print('file size: ${_file.lengthSync()}');
    //
    // var _images = await db.getPicture(reportId, 0);
    // File _photo = File('$path/photo.jpg');
    // _photo.writeAsBytes(_images[0].picture);

    // GoogleAuthApi.signOut();
    // print('Google sign out');
    // return;
    final user = await GoogleAuthApi.signIn();

    if (user == null) {
      print('User is null, sending is stoped');
      return;
    };

    final mailAddress = 'serviceavailable.test@gmail.com';
    final auth = await user.authentication;
    final token = auth.accessToken!;

    print('Authenticated: $mailAddress');

    final smtpServer = gmailSaslXoauth2(mailAddress, token);

    final message = Message()
      ..from = Address(mailAddress, 'Firkat')
      ..recipients = [prefs.getString('recipients')]
      ..subject = prefs.getString('subject')
      //..text = prefs.getString('text')
      ..html = '''
      <h1>Test</h1>
      <p>This is a test email</p>
      <img src="cid:app"/>
      '''
      ..attachments = [
        FileAttachment(File('$path/$fileName'))
        ..fileName = 'Отчёт_$reportId.xlsx'
        ..location = Location.attachment
      ];

    try {
      showSnackBar('Sending message...');
      print('Trying to send...Wait...');
      await send(message, smtpServer);
      showSnackBar('Sent email successfully!');
    } on MailerException catch (e) {
      print('Email didn\'t sent');
      print(e);
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