import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:rus_bur_service/models/report.dart';

import '../main.dart';

class MailSender {
  Future<void> sendMail(String fileName, int reportId) async {

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

    final Email email = Email(
      body: 'Сервисный отчёт',
      subject: 'Тестовый вариант',
      recipients: ['dr.firkat@yandex.ru'],
      cc: [],
      //bcc: ['bcc@example.com'],
      attachmentPaths: ['$path/$fileName'], //'$path/photo.jpg'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

  }
}