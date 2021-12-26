import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:rus_bur_service/api/google_sign_in_api.dart';

class MailerPage extends StatefulWidget {
  const MailerPage({Key? key}) : super(key: key);

  @override
  _MailerPageState createState() => _MailerPageState();
}

class _MailerPageState extends State<MailerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mailer Page'),
      ),
      body: Center(
        child: ElevatedButton.icon(
            onPressed: sendEmail,
            icon: Icon(Icons.person),
            label: Text('НАЖМИ СЮДА'))
      ),
    );
  }

  Future sendEmail () async {
    // GoogleAuthApi.signOut();
    // return;
    final user = await GoogleAuthApi.signIn();

    if (user == null) return;

    final mailAddress = 'serviceavailable.test@gmail.com';
    final auth = await user.authentication;
    final token = auth.accessToken!;

    print('Authenticated: $mailAddress');

    final smtpServer = gmailSaslXoauth2(mailAddress, token);

    final message = Message()
        ..from = Address(mailAddress, 'Firkat')
        ..recipients = ['dr.firkat@ya.ru']
        ..subject = 'Hello Firkat'
        ..text = 'This is a test email!';

    try {
      print('Trying to send message...');
      await send(message, smtpServer);
      showSnackBar('Sent email successfully!');
    } on MailerException catch (e) {
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

    ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
  }
}
