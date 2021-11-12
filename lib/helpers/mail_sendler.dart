import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:flutter_email_sender/flutter_email_sender.dart';

class MailSender {
  Future<void> sendMail(String fileName) async {

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

    final Email email = Email(
      body: 'Сервисный отчёт',
      subject: 'Тестовый вариант',
      recipients: ['dr.firkat@yandex.ru'],
      cc: [],
      //bcc: ['bcc@example.com'],
      attachmentPaths: ['$path/$fileName'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

  }
}